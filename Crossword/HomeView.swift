import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showSettingsView = false
    @State private var showCrosswordBoardView = false
    @State private var hasExistingGame = false

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    VStack {
                        Button(action: {
                            showCrosswordBoardView.toggle()
                        }) {
                            Text("New Game")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $showCrosswordBoardView) {
                            CrosswordBoardView()
                        }
                        
                        if hasExistingGame {
                            Button(action: {
                                // Continue the existing game
                            }) {
                                Text("Continue")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                    
                    VStack {
                        Text("Stats view goes here")
                    }
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar")
                    }
                    .tag(1)
                }
                .padding()
            }
            .navigationBarTitle("Crossword Puzzle", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showSettingsView.toggle()
            }) {
                Image(systemName: "gear")
            })
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
