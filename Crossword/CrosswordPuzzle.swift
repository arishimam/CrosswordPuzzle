// Structure for CrosswordPuzzle
struct CrosswordPuzzle: Codable {
    let puzzle: String
    let key: Key
    let metadata: Metadata
}

// Structure for Key
struct Key: Codable {
    let across: [String: Clue]
    let down: [String: Clue]
}

// Structure for Clue
struct Clue: Codable {
    let clue: String
    let word: String
}

// Structure for Metadata
struct Metadata: Codable {
    let author: String
    let editor: String
    let rows: Int
    let columns: Int
    let date: Date
}

// Structure for Date
struct Date: Codable {
    let month: Int
    let day: Int
    let year: Int
}
