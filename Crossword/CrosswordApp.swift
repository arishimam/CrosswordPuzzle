//
//  CrosswordApp.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import SwiftUI

@main
struct CrosswordApp: App {
    @StateObject var gameManager = GameManager(puzzleFile: "puzzle")

    var body: some Scene {
        WindowGroup {
            HomeView(gameManager: gameManager)
        }
    }
}

