//
//  CrosswordService.swift
//  Crossword
//
//  Created by csuftitan on 5/18/23.
//

import Foundation

class CrosswordService {
    
    func loadPuzzle(from file: String) -> CrosswordPuzzle? {
        // Ensure that a file with the given name exists in the app's main bundle
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            print("Could not find \(file).json in main bundle.")
            return nil
        }
        
        do {
            // Load the data from the file
            let data = try Data(contentsOf: url)
            
            // Use a JSONDecoder to convert the data into a CrosswordPuzzle
            let decoder = JSONDecoder()
            let puzzle = try decoder.decode(CrosswordPuzzle.self, from: data)
            
            // print(puzzle)
            
            return puzzle
        } catch {
            print("Error loading or parsing \(file).json: \(error)")
            return nil
        }
    }
}
