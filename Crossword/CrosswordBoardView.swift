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
    @Binding var letter: String
    //@Binding var cell: Cell
    
    var body: some View {
        TextField("", text: $letter)
            .multilineTextAlignment(.center)
            .frame(width:25, height: 25)
            .font(.headline)
            .background(Color.white)
            .disableAutocorrection(true)
            .keyboardType(.default)
            .textContentType(.oneTimeCode)
            .onChange(of: letter) { newValue in
                // limit input to 1 character
                if newValue.count > 1 {
                    letter = String(newValue.prefix(1))
                }
            }
    }
}


struct CrosswordBoardView: View {
    let gridSize = 15
//    let cellSize: CGFloat = 30
    
    @State var cells: [[String]] = Array(repeating: Array(repeating: "", count: 15), count:15)
    var body: some View {
        VStack(spacing:0){
            ForEach(0 ..< gridSize, id:\.self) { row in
                HStack(spacing:0) {
                    ForEach(0 ..< gridSize, id:\.self) { column in
//                        Rectangle()
//                            .stroke(Color.black, lineWidth: 1)
//                            .frame(width: cellSize, height: cellSize)
                        CellView(letter: $cells[row][column])
                            .border(Color.black, width: 1)
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
