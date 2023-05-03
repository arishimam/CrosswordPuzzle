import SwiftUI

struct StatsView: View {
    @State private var selectedDifficulty = 0

    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Picker("Difficulty", selection: $selectedDifficulty) {
                Text("Beginner").tag(0)
                Text("Expert").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Form {
                Section(header: Text("Games")) {
                    HStack {
                        Text("Games Started:")
                        Spacer()
                        Text("0") // Replace with the actual value
                    }
                    HStack {
                        Text("Games Won:")
                        Spacer()
                        Text("0") // Replace with the actual value
                    }
                    HStack {
                        Text("Win Rate:")
                        Spacer()
                        Text("0%") // Replace with the actual value
                    }
                }

                Section(header: Text("Time")) {
                    HStack {
                        Text("Best Time:")
                        Spacer()
                        Text("00:00") // Replace with the actual value
                    }
                    HStack {
                        Text("Average Time:")
                        Spacer()
                        Text("00:00") // Replace with the actual value
                    }
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
