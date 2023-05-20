//
//  WinView.swift
//  Crossword
//
//  Created by csuftitan on 5/19/23.
//

import Foundation
import SwiftUI

struct ConfettiAnimation: View {
    @State private var animate = false

    var body: some View {
        VStack {
            ForEach(0..<100) { _ in
                HStack {
                    ForEach(0..<25) { _ in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.random)
                            .offset(y: animate ? CGFloat.random(in: 600...1000) : -100)
                            .animation(Animation.linear(duration: Double.random(in: 3...5)).repeatForever(autoreverses: false))
                    }
                }
            }
        }
        .onAppear() {
            animate = true
        }
    }
}

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}



struct WinView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Congratulations!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("You've won!")
                    .font(.title)
                    .padding()
            }
            ConfettiAnimation()
                .opacity(0.4)
        }
    }
}

