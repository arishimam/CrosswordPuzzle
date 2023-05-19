//
//  Clue.swift
//  Crossword
//
//  Created by csuftitan on 5/17/23.
//

import Foundation

struct Clue {
    let id: Int
    let direction: String
    let position: (Int, Int)
    let text: String

    // add initializer
    init(id: Int, direction: String, position: (Int, Int), text: String) {
        self.id = id
        self.direction = direction
        self.position = position
        self.text = text
    }
    
    // Define enum for direction
    enum Direction {
        case across, down
    }
}

