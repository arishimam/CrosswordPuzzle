//
//  PauseView.swift
//  Crossword
//
//  Created by csuftitan on 5/19/23.
//

import Foundation
import SwiftUI

struct PauseView: View {
    @Binding var elapsedTime: Int
    var resumeTimer: () -> Void

    var body: some View {
        VStack {
            Text("Game is Paused")
            Text("Elapsed Time: \(elapsedTime)")
            Button(action: {
                resumeTimer()
            }) {
                Text("Resume")
            }
        }
    }
}
