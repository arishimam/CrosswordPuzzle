//
//  CrosswordApp.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import SwiftUI

@main
struct CrosswordApp: App {
    // Randomly chooses crossword puzzle from this array of strings of JSON puzzle files
//    let puzzleFiles = ["puzzle", "puzzle2", "puzzle3"]

//    init() {
//        let randomPuzzleFile = puzzleFiles.randomElement() ?? "puzzle" // Fallback to "puzzle1" if the array is empty
//        _gameManager = StateObject(wrappedValue: GameManager(puzzleFile: randomPuzzleFile))
//    }
    @StateObject var gameManager = GameManager(puzzleFile: "puzzle")

    var body: some Scene {
        WindowGroup {
            HomeView(gameManager: gameManager)
//            WinView()
        }
    }
}

