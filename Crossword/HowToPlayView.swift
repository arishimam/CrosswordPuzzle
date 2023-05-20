import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Play")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Section {
                    Text("Crossword puzzles are a word game where you fill in white squares with letters to form words, based on the given clues. Here are the rules to play crossword puzzles:")
                    
                    Text("Rule 1: Read the Clues")
                        .fontWeight(.bold)
                    Text("The crossword puzzle contains a list of clues, each corresponding to a word that needs to be filled in the grid. Read the clues carefully to understand the word and its context.")
                    
                    Text("Rule 2: Solve the Easy Clues First")
                        .fontWeight(.bold)
                    Text("Start by solving the easy clues that you know the answers to. These will help you fill in letters and uncover intersecting words.")
                    
                    Text("Rule 3: Use Crossword Grid Numbering")
                        .fontWeight(.bold)
                    Text("The crossword grid has numbered squares indicating the starting position of each word. Pay attention to the numbering as it helps in locating the correct answer position.")
                    
                    Text("Rule 4: Follow the Crossword Grid")
                        .fontWeight(.bold)
                    Text("Fill in the answers according to the provided grid. Each white square should contain one letter, and black squares separate the words.")
                }
                Section {
                    Text("Rule 5: Check Crossword Symmetry")
                        .fontWeight(.bold)
                    Text("Crossword puzzles usually have symmetry, where the pattern of black and white squares is mirrored across a central axis. Use the symmetry to your advantage when solving.")
                    
                    Text("Rule 6: Use Word Length and Clue Hints")
                        .fontWeight(.bold)
                    Text("The clue often provides hints about the word's length, such as '3 letters,' '6 letters,' etc. Use these hints along with the provided letters to solve the word.")
                    
                    Text("Rule 7: Pay Attention to Wordplay")
                        .fontWeight(.bold)
                    Text("Some crossword clues involve wordplay, such as anagrams, puns, or other linguistic tricks. Look for any wordplay indicators or cleverly worded clues to find the solution.")
                    
                    Text("Rule 8: Eliminate Incorrect Answers")
                        .fontWeight(.bold)
                    Text("If you're uncertain about an answer, work on the intersecting words to gain more clues. Eliminate incorrect answers by ensuring the words fit both across and down.")
                    
                    Text("Rule 9: Enjoy the Challenge!")
                        .fontWeight(.bold)
                    Text("Crossword puzzles are meant to be challenging and enjoyable. Take your time, use your knowledge and reasoning skills, and have fun while solving!")
                }
                // Add more rules as needed
            }
            .padding()
        }
        .navigationBarTitle("How to Play", displayMode: .inline)
    }
}


struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
