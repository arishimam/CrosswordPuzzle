import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Play")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Add the rules of the crossword game here
                Text("Rule 1: ...")
                Text("Rule 2: ...")
                Text("Rule 3: ...")
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
