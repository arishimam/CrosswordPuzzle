//
//  CrosswordBoardView.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import SwiftUI


struct Cell {
    var userInput: String = ""
    var isBlocked: Bool = false
    var correctAnswer: String
    var isIncorrect: Bool = false
    var number: Int?
    var row: Int
    var column: Int
    
    
    init(letter: Character) {
        self.correctAnswer = String(letter)
        self.isBlocked = (letter == " ")
        self.row = 0
        self.column = 0
    }
}


struct CellView: View {
    @Binding var cell: Cell
    @Binding var showAnswers: Bool
    @Binding var isCheckingAnswers:Bool
    @Binding var userInputStore: [String: String]
    
    
    var body: some View {
        ZStack {
            if cell.isBlocked {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 25, height: 25)
            } else {
                if showAnswers {
                    Text(cell.correctAnswer)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .background(Color.white)
                        .frame(width: 25, height: 25)
                } else {
                    TextField("", text: $cell.userInput)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .background(Color.white)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(isCheckingAnswers && cell.isIncorrect ? .red : .black)
                        .frame(width: 25, height: 25)
                        .onChange(of: cell.userInput) { newValue in
                            // limit input to 1 character
                            if newValue.count > 1 {
                                cell.userInput = String(newValue.prefix(1))
                            }
                            let cellKey = "\(cell.row)-\(cell.column)"
                            if newValue.isEmpty {
                                userInputStore.removeValue(forKey: cellKey)
                            } else {
                                userInputStore[cellKey] = cell.userInput
                            }
                        }

                }
                
                GeometryReader { geometry in
                    if let number = cell.number {
                        Text("\(number)")
                            .font(.footnote)
                            .font(.system(size: 10))
                            .foregroundColor(.blue)
                            .opacity(0.6)
                            .offset(x: -geometry.size.width / 2 + 15, y: -geometry.size.height / 2 + 15)
                    }
                }
            }
        }
        .frame(width: 25, height: 25)
    }
}

class GameManager: ObservableObject {
    @Published var puzzle: CrosswordPuzzle?
    @Published var cells: [[Cell]] = []
    @Published var showSettingsView = false
    @Published var isLoading: Bool = true  // Flag to track the loading state
    @Published var showAnswers: Bool = false
    @Published var isCheckingAnswers: Bool = false
    @Published var userInputStore: [String: String] = [:]
    @Published var elapsedTime: Int = 0 // in seconds
    @Published var timer: Timer? = nil
    @Published var isPaused: Bool = false
    @Published var showPauseView: Bool = false
    
//    @Published var isNewGameDataReady = false
//    @Published var isExistingGameDataReady = false
    
    
    let puzzleFile: String
    
    init(puzzleFile: String) {
        self.puzzleFile = puzzleFile
//        self.loadData()
    }
    
//    // Create a method to save the game's state
//    func saveGameState() {
//        let userDefaults = UserDefaults.standard
//        do {
//            // Save the current puzzle
//            let puzzleData = try JSONEncoder().encode(puzzle)
//            userDefaults.set(puzzleData, forKey: "puzzle")
//
//            // Save the user's input
//            userDefaults.set(userInputStore, forKey: "userInputStore")
//        } catch {
//            print("Failed to save game state: \(error)")
//        }
//    }
    
//    // Create a method to load the game's state
//    func loadGameState() {
//        let userDefaults = UserDefaults.standard
//        do {
//            // Load the puzzle
//            if let puzzleData = userDefaults.data(forKey: "puzzle") {
//                puzzle = try JSONDecoder().decode(CrosswordPuzzle.self, from: puzzleData)
//            }
//
//            // Load the user's input
//            userInputStore = userDefaults.dictionary(forKey: "userInputStore") as? [String: String] ?? [:]
//            isExistingGameDataReady = true
//        } catch {
//            print("Failed to load game state: \(error)")
//        }
//    }
//
//    // Create a method to start a new game
//    func newGame() {
//        // Load a new puzzle and reset user input
//        loadData()
//        isNewGameDataReady = true
//    }
//
    // Create a separate method for loading the data
    func loadData() {
        let service = CrosswordService()
        puzzle = service.loadPuzzle(from: puzzleFile)
        if let puzzle = puzzle {
            //setupBoard(puzzle: puzzle)
            setupBoard(puzzle: puzzle, resetUserInput: true)
        }
        isLoading = false
//        isExistingGameDataReady = true
    }
    

    func setupBoard(puzzle: CrosswordPuzzle, resetUserInput: Bool = false) {
        let lines = puzzle.puzzle.components(separatedBy: "\n").filter { !$0.isEmpty }
        var newCells = [[Cell]]()
        var cellNum = 1 // tracker for cell number
        var previousRow = [Cell]()
        for (rIndex, line) in lines.enumerated() {
            var row = [Cell]()
            for (cIndex, letter) in line.enumerated() {
                var cellNumber: Int? = nil
                var cell = Cell(letter: letter)
                // Update the cell's row and column
                cell.row = rIndex
                cell.column = cIndex
                // Reset user input if requested
                if resetUserInput || showAnswers {
                    cell.userInput = ""
                } else {
                    let cellKey = "\(rIndex)-\(cIndex)" // Here is the change
                    cell.userInput = userInputStore[cellKey, default: ""]
                }
                // Check if cell isn't blocked and either it's at the start of a line/column or the previous cell is blocked
                let isStartOfHorizontalWord = !cell.isBlocked && (cIndex == 0 || row.last?.isBlocked == true)
                let isStartOfVerticalWord = !cell.isBlocked && (previousRow.isEmpty || previousRow[cIndex].isBlocked)
                if isStartOfHorizontalWord || isStartOfVerticalWord {
                    cellNumber = cellNum
                    cellNum += 1
                }
                cell.number = cellNumber
                row.append(cell)
            }
            newCells.append(row)
            previousRow = row
        }
        cells = newCells
    }
    
    func hasUserWon() -> Bool {
        for row in cells {
            for cell in row {
                if !cell.isBlocked && (cell.userInput.lowercased() != cell.correctAnswer.lowercased() || cell.userInput.isEmpty) {
                    return false
                }
            }
        }
        return true
    }

    func checkAnswers() {
        for row in cells.indices {
            for column in cells[row].indices {
                cells[row][column].isIncorrect = cells[row][column].userInput.lowercased() != cells[row][column].correctAnswer.lowercased()
            }
        }
        if hasUserWon() {
            print("Congratulations, you've won!")
            // Here you can add code to show some winning message or perform other tasks
        }
    }
    
    // Start timer
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if !self.isPaused {
                self.elapsedTime += 1
            }
        }
    }

    // Pause timer
    func pauseTimer() {
        self.isPaused = true
        self.showPauseView = true
    }
    
    // Resume timer
    func resumeTimer() {
        self.isPaused = false
    }
    
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}



struct CrosswordBoardView: View {
    @EnvironmentObject var gameManager: GameManager

    var body: some View {
        ScrollView {
            // Timer and pause button
            HStack {
                Text("Time: \(gameManager.formatTime(seconds: gameManager.elapsedTime))")
                    .alignmentGuide(.leading) { _ in 0 }
                Button(action: gameManager.pauseTimer) {
                    Text("Pause")
                        .alignmentGuide(.trailing) { _ in 0 }
                }
            }
            Group {
                if gameManager.isLoading {
                    Text("Loading puzzle...")
                } else {
                    VStack(spacing: 0){
                        ForEach(0 ..< gameManager.cells.count, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0 ..< gameManager.cells[row].count, id: \.self) { column in
                                    CellView(cell: $gameManager.cells[row][column], showAnswers: $gameManager.showAnswers, isCheckingAnswers: $gameManager.isCheckingAnswers, userInputStore: $gameManager.userInputStore)
                                        .border(Color.black, width: 1)

                                }
                            }
                        }
                    }
                    .navigationBarTitle("Crossword Puzzle", displayMode: .inline)
                    .navigationBarItems(leading: HStack {
                        Button(action: { self.gameManager.showAnswers.toggle() }) {
                            Text(gameManager.showAnswers ? "Hide Answers" : "Show Answers")
                        }
                        Button(action: {
                            self.gameManager.isCheckingAnswers.toggle()
                            if self.gameManager.isCheckingAnswers {
                                self.gameManager.checkAnswers()
                            }
                        }) {
                            Text(gameManager.isCheckingAnswers ? "Hide Mistakes" : "Check Answers")
                        }
                    }, trailing: Button(action: {
                        gameManager.showSettingsView.toggle()
                    }){
                        Image(systemName: "gear")
                    })
                    .sheet(isPresented: $gameManager.showSettingsView){
                        SettingsView()
                    }
                    .padding(20)
                }
            }
//            .onAppear(perform: {
//                gameManager.loadData()
//                if let puzzle = gameManager.puzzle {
//                    gameManager.setupBoard(puzzle: puzzle, resetUserInput: true)
//                }
//            })
            .onChange(of: gameManager.showAnswers) { _ in
                if let puzzle = gameManager.puzzle {
                    gameManager.setupBoard(puzzle: puzzle)
                }
            }
            
            // Display the clues
            if let puzzle = gameManager.puzzle {
                HStack{
                    VStack(alignment: .leading) {
                        Text("Across:")
                            .bold()
                            .padding(.top)
                        ForEach(puzzle.key.across.keys.sorted(), id: \.self) { key in
                            Text("\(key). \(puzzle.key.across[key]!.clue)")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(alignment: .leading) {
                        Text("Down:")
                            .bold()
                            .padding(.top)
                        ForEach(puzzle.key.down.keys.sorted(), id: \.self) { key in
                            Text("\(key). \(puzzle.key.down[key]!.clue)")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            }
        }
        .onAppear {
            self.gameManager.startTimer()
        }
        .sheet(isPresented: $gameManager.showPauseView) {
            PauseView(elapsedTime: $gameManager.elapsedTime, resumeTimer: self.gameManager.resumeTimer)
        }
    }
}

struct CrosswordBoardView_Previews: PreviewProvider {
    static var previews: some View {
        CrosswordBoardView().environmentObject(GameManager(puzzleFile: "puzzle"))
    }
}
