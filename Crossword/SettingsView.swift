import SwiftUI

struct SettingsView: View {
    @State private var boardDifficulty = 0
    @State private var showTimer = false
    @State private var showMistakes = false
    @State private var skipFilledSquares = false
    @State private var showHowToPlayView = false
    @State private var showHistoryView = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        // Update the action to set showHowToPlayView to true
                        showHowToPlayView = true
                    }) {
                        Text("How to play")
                    }
                    // Add the following line to present HowToPlayView as a sheet
                    .sheet(isPresented: $showHowToPlayView) {
                        HowToPlayView()
                    }
                    
                    Button(action: {
                        // Set showHistoryView to true when the button is tapped
                        showHistoryView = true
                    }) {
                        Text("History of Crossword Puzzles")
                    }
                    // Present HistoryView as a sheet when showHistoryView is true
                    .sheet(isPresented: $showHistoryView) {
                        HistoryView()
                    }
                }
                
                Section(header: Text("Start board on:")) {
                    Picker("Difficulty", selection: $boardDifficulty) {
                        Text("Beginner").tag(0)
                        Text("Expert").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Toggle("Show timer", isOn: $showTimer)
                    Toggle("Show mistakes", isOn: $showMistakes)
                }
                
                Section(header: Text("When completing clues:")) {
                    Toggle("Skip filled squares", isOn: $skipFilledSquares)
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                // Handle done button action
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
