//
//  PauseView.swift
//  Crossword
//
//  Created by csuftitan on 5/19/23.
//

import Foundation
import SwiftUI

struct PauseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var gameManager: GameManager

    var body: some View {
        VStack {
            Text("Game is Paused")
            Text("Elapsed Time: \(gameManager.formatTime(seconds: gameManager.elapsedTime))")
            Button(action: {
                gameManager.resumeTimer()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Resume")
            }
        }
    }
}
