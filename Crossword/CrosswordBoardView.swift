//
//  CrosswordBoardView.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//


// TO-DO
// Cell labels
// Black out cells and don't allow input
// Have text input automatically  move in correct direction
import SwiftUI

struct Cell {
    var letter: String = ""
    var isBlocked: Bool = false
    
    var cellNum: Int = 0
}

struct CellView: View {
    //@Binding var letter: String
    @Binding var cell: Cell
    
    var body: some View {
        
        ZStack {
            
            if cell.isBlocked {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 25, height: 25)
            }
            
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
    let gridSize = 15
//    let cellSize: CGFloat = 30
    
    
    @State var cells: [[Cell]] = Array(repeating: Array(repeating: Cell(), count: 15), count:15)
    
    init() {
           // Set cells to be blocked where necessary
           cells[3][3].isBlocked = true
           cells[3][11].isBlocked = true
           cells[6][7].isBlocked = true
           cells[6][8].isBlocked = true
           cells[6][9].isBlocked = true
           cells[8][6].isBlocked = true
           cells[9][6].isBlocked = true
           cells[10][6].isBlocked = true
           cells[11][3].isBlocked = true
           cells[11][11].isBlocked = true
       }
    
    var body: some View {
        VStack(spacing:0){
            ForEach(0 ..< gridSize, id:\.self) { row in
                HStack(spacing:0) {
                    ForEach(0 ..< gridSize, id:\.self) { column in
//                        Rectangle()
//                            .stroke(Color.black, lineWidth: 1)
//                            .frame(width: cellSize, height: cellSize)
                        CellView(cell: $cells[row][column])
                            .border(Color.black, width:1)
                            
                    }
                }
            }
        }
        .padding(20)
    }
}

struct CrosswordBoardView_Previews: PreviewProvider {
    static var previews: some View {
        CrosswordBoardView()
    }
}
