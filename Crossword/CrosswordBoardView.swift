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

struct CrosswordPuzzle: Decodable {
    let puzzle: String
    let key: Key
    let metadata: Metadata
    
    struct Key: Decodable {
        let across: [String: ClueData]
        let down: [String: ClueData]
        
        struct ClueData: Decodable, Hashable {
            let clue: String
            let word: String
        }
    }
    struct Metadata: Decodable {
        let author: String
        let editor: String
        let rows: Int
        let columns: Int
        let date: DateData
        
        struct DateData: Decodable {
            let month: Int
            let day: Int
            let year: Int
        }
    }
}

struct Cell {
    var letter: String
    var isBlocked: Bool
    var row: Int
    var column: Int
    var clueNumber: Int?
    var acrossClue: CrosswordPuzzle.Key.ClueData?
    var acrossWord: String?
    var downClue: CrosswordPuzzle.Key.ClueData?
    var downWord: String?
}

struct CellView: View {
    var cell: Cell
    var viewModel: CrosswordBoardViewModel

    var body: some View {
        ZStack(alignment: .topLeading) {
            if cell.isBlocked {
                Rectangle()
                    .fill(Color.black)
            } else {
                FocusedTextField(text: Binding(
                    get: { self.cell.letter },
                    set: { viewModel.cells[cell.row][cell.column].letter = $0 }),
                    isUserInteractionEnabled: !cell.isBlocked,
                    onCommit: {
                        viewModel.completionStatus = viewModel.checkCompletion() ? .win : .lose
                    },
                    onUpdate: { newText in
                        viewModel.cells[cell.row][cell.column].letter = newText
                    })
                    .disableAutocorrection(true)
                    .font(.headline)
                    .background(Color.white)
            }
        }
        .frame(width: 25, height: 25)
        .border(Color.black, width: 1)
    }
}

class CrosswordBoardViewModel: ObservableObject {
    let gridSize = 15

    @Published var showAlert: Bool = false
    @Published var alertTitle: String = "Test"
    @Published var alertMessage: String = "Test"
    @Published var completionStatus: CompletionStatus?
    @Published var showSettingsView: Bool = false


    enum CompletionStatus {
        case win, lose
    }
    
    
    @Published var cells: [[Cell]] = (0..<15).map { row in
        (0..<15).map { column in
            Cell(letter: "", isBlocked: false, row: row, column: column)
        }
    }
    
    // State variable for crosswordPuzzle
    var crosswordPuzzle: CrosswordPuzzle? = nil
    
    func loadPuzzleData() {
        guard let url = Bundle.main.url(forResource: "puzzle", withExtension: "json") else {
            print("Failed to locate puzzle.json in bundle.")
            return
        }
        
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "puzzle", ofType: "json") {
                do {
                    let jsonData = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let decodedPuzzle = try decoder.decode(CrosswordPuzzle.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.setupBoard(puzzle: decodedPuzzle.puzzle, key: decodedPuzzle.key)
                        self.crosswordPuzzle = decodedPuzzle
                    }
                } catch {
                    print("Error loading or decoding JSON: \(error)")
                }
            }
        }
    }
    
    func setupBoard(puzzle: String, key: CrosswordPuzzle.Key) {
        let puzzleRows = puzzle.split(separator: "\n")
        var clueNumber = 1
        
        for (i, row) in puzzleRows.enumerated() {
            let rowChars = Array(row)
            for (j, char) in rowChars.enumerated() {
                var cell = Cell(letter: "", isBlocked: false, row: i, column: j)
                
                if char.isWhitespace {
                    cell.isBlocked = true
                } else {
                    if let acrossClueData = key.across[String(i+1)],
                       (j == 0 || cells[i][j-1].isBlocked) {
                        cell.acrossClue = acrossClueData
                        cell.acrossWord = acrossClueData.word
                        cell.clueNumber = clueNumber
                    }
                    
                    if let downClueData = key.down[String(j+1)],
                       (i == 0 || cells[i-1][j].isBlocked) {
                        cell.downClue = downClueData
                        cell.downWord = downClueData.word
                        cell.clueNumber = clueNumber
                    }
                    
                    if cell.clueNumber != nil {
                        clueNumber += 1
                    }
                }
                
                cells[i][j] = cell
            }
        }
    }
    
    func checkBoard() -> Bool {
        // Check Across Words
        for (_, row) in cells.enumerated() {
            var word = ""
            var expectedWord: String? = nil
            
            for (j, cell) in row.enumerated() {
                if cell.isBlocked || j == row.count - 1 {
                    // Check the word when reaching a blocked cell or the end of the row.
                    if word != expectedWord {
                        return false
                    }
                    
                    // Reset the word and expected word.
                    word = ""
                    expectedWord = nil
                } else if cell.acrossClue != nil {
                    // If the cell is the start of a new word, update the expected word.
                    expectedWord = cell.acrossWord
                }
                
                // If the cell is not blocked, add its letter to the word.
                if !cell.isBlocked {
                    word += cell.letter
                }
            }
        }
        
        // Check Down Words
        for column in 0..<gridSize {
            var word = ""
            var expectedWord: String? = nil
            
            for row in 0..<gridSize {
                let cell = cells[row][column]
                
                if cell.isBlocked || row == gridSize - 1 {
                    // Check the word when reaching a blocked cell or the end of the column.
                    if word != expectedWord {
                        return false
                    }
                    
                    // Reset the word and expected word.
                    word = ""
                    expectedWord = nil
                } else if cell.downClue != nil {
                    // If the cell is the start of a new word, update the expected word.
                    expectedWord = cell.downWord
                }
                
                // If the cell is not blocked, add its letter to the word.
                if !cell.isBlocked {
                    word += cell.letter
                }
            }
        }
        
        // If all words match the correct answers, return true.
        return true
    }
    func checkCompletion() -> Bool {
        // You can use the logic to check the completion of the crossword puzzle here.
        // For the sake of example, I'm just returning false.
        return false
    }
}

struct CrosswordBoardView: View {
    @StateObject var viewModel = CrosswordBoardViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< viewModel.gridSize, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< viewModel.gridSize, id: \.self) { column in
                        CellView(cell: viewModel.cells[row][column], viewModel: viewModel)
                            .border(Color.black, width: 1)
                    }
                }
            }
            HStack {
                VStack{
                    Text("Across")
                        .font(.subheadline)
                    if let acrossClues = viewModel.crosswordPuzzle?.key.across.sorted(by: { $0.key < $1.key }) {
                        List(acrossClues, id: \.key) { key, clue in
                            Text("\(key). \(clue.clue)")
                                .font(.system(size: 12)) // Set font size as per your need
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)// Adjust this as per your needs
                
                VStack{
                    Text("Down")
                        .font(.subheadline)
                    if let downClues = viewModel.crosswordPuzzle?.key.down.sorted(by: { $0.key < $1.key }) {
                        List(downClues, id: \.key) { key, clue in
                            Text("\(key). \(clue.clue)")
                                .font(.system(size: 12)) // Set font size as per your need
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)// Adjust this as per your needs
            }
        }
        .navigationBarTitle("Crossword Puzzle", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
                viewModel.showSettingsView.toggle()
        }) {
            Image(systemName: "gear")
        })
        .sheet(isPresented: $viewModel.showSettingsView) {
            SettingsView()
        }
        .padding(20)
        .onAppear(perform: viewModel.loadPuzzleData)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}




