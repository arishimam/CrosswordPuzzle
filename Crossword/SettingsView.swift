import SwiftUI

struct SettingsView: View {
    @State private var boardDifficulty = 0
    @State private var showTimer = false
    @State private var showMistakes = false
    @State private var skipFilledSquares = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        // Handle "How to play" button action
                    }) {
                        Text("How To Play")
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
