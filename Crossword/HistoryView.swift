//
//  HistoryView.swift
//  Crossword
//
//  Created by csuftitan on 5/19/23.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("History of Crossword Puzzles")
                    .font(.title)
                    .padding()
                
                Text("Crossword puzzles are a popular word game that originated in the early 20th century. They were first created by Arthur Wynne and published in the New York World newspaper on December 21, 1913. The puzzle quickly gained popularity and became a regular feature in newspapers around the world.")
                
                Text("The crossword grid consists of white and black squares. The goal is to fill the white squares with letters to form words, using the given clues as guidance. The intersecting of horizontal and vertical words creates a challenging and enjoyable solving experience.")
                
                Text("Over the years, crossword puzzles have evolved and diversified. Different types of crosswords, such as cryptic crosswords and themed crosswords, have emerged, catering to various solving preferences. Cryptic crosswords, popular in the United Kingdom, feature clues with wordplay and often require a deep understanding of language nuances. Themed crosswords, on the other hand, revolve around a specific topic or have hidden themes connecting the answers.")
                
                Text("Crossword puzzles gained immense popularity during the 1920s and 1930s, becoming a widespread form of entertainment. They provided a welcome distraction during the Great Depression and World War II, offering mental stimulation and a temporary escape from the hardships of the time.")
                
                Text("In the digital age, crossword puzzles have transitioned to various platforms. Online crossword websites, mobile apps, and puzzle books allow enthusiasts to solve puzzles anytime, anywhere. The accessibility and availability of puzzles have further contributed to the enduring popularity of crosswords.")
                
                Text("Crossword puzzles have become not only a form of entertainment but also a way to sharpen cognitive skills, improve vocabulary, and stimulate mental activity. They continue to be a beloved pastime for people of all ages.")
            }
            .padding()
        }
    }
}
