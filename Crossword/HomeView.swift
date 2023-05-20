import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showSettingsView = false
    @State private var showCrosswordBoardView = false
//    @State private var hasExistingGame = false
    
    @StateObject var gameManager: GameManager

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    VStack {
                        NavigationLink(destination: CrosswordBoardView().environmentObject(gameManager)){
                            Text("New Game")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .onAppear {
                            gameManager.loadData()
                        }

                        if gameManager.puzzle != nil {
                            Button(action: {
                                // Continue the existing game
//                                if gameManager.puzzle != nil {
//                                    self.hasExistingGame = true
//                                }
                            }) {
                                Text("Continue")
                                    .font(.title2)
                                    .padding()
//                                    .background(gameManager.puzzle != nil ? Color.green : Color.gray)
                                    .background(.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(gameManager.puzzle == nil)
                        }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                    
                    StatsView()
                        .tabItem {
                            Label("Stats", systemImage: "chart.bar")
                        }
                        .tag(1)
                    
                    ProfileView()  // Add ProfileView as a tab item
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                        .tag(2)

                    
                    
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
        HomeView(gameManager: GameManager(puzzleFile: "puzzle"))
    }
}
