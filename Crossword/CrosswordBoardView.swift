//
//  CrosswordBoardView.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//


// TO-DO
// Cell labels
// Have text input automatically move in correct direction

import SwiftUI

struct Cell {
    var letter: String
    var isBlocked: Bool = false

    var cellNum: Int = 0
    
    init(letter: Character) {
        self.letter = String(letter)
        self.isBlocked = (letter == " ")
    }
}


struct CellView: View {
    @Binding var cell: Cell
    
    var body: some View {
        
            if cell.isBlocked {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 25, height: 25)
                    .background(Color.black)
            } else {
                TextField("", text: $cell.letter)
                    .multilineTextAlignment(.center)
                    .frame(width:25, height: 25)
                    .font(.headline)
                    .background(Color.white)
                    .disableAutocorrection(true)
                    .keyboardType(.default)
                    .textContentType(.oneTimeCode)
                    .disabled(cell.isBlocked)
                    .onChange(of: cell.letter) { newValue in
                        // limit input to 1 character
                        if newValue.count > 1 {
                            cell.letter = String(newValue.prefix(1))
                        }
                    }
            }
    }
}


struct CrosswordBoardView: View {
    @State var puzzle: CrosswordPuzzle?
    @State var cells: [[Cell]] = []
    @State private var showSettingsView = false
    @State var isLoading: Bool = true  // Flag to track the loading state
    
    let puzzleFile: String
    
    // Create a separate method for loading the data
    func loadData() {
        let service = CrosswordService()
        puzzle = service.loadPuzzle(from: puzzleFile)
        if let puzzle = puzzle {
            setupBoard(puzzle: puzzle)
        }
        isLoading = false
    }
    
    // Sets cells to be blocked where necessary
    func setupBoard(puzzle: CrosswordPuzzle) {
        let rows = puzzle.puzzle.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n")
        cells = rows.map { row in
            row.map { Cell(letter: $0) }
        }
    }
    
    var body: some View {
        Group {
            if isLoading {
                Text("Loading puzzle...")
            } else {
                VStack(spacing: 0){
                    ForEach(0 ..< cells.count, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0 ..< cells[row].count, id: \.self) { column in
                                CellView(cell: $cells[row][column])
                                    .border(Color.black, width: 1)
                            }
                        }
                    }
                }
                .navigationBarTitle("Crossword Puzzle", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    showSettingsView.toggle()
                }){
                    Image(systemName: "gear")
                })
                .sheet(isPresented: $showSettingsView){
                    SettingsView()
                }
                .padding(20)
            }
        }
        .onAppear(perform: loadData)
    }
}

struct CrosswordBoardView_Previews: PreviewProvider {
    static var previews: some View {
        CrosswordBoardView(puzzleFile: "puzzle")
    }
}
