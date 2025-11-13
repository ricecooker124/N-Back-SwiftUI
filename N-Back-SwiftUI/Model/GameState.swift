//
//  GameState.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import Foundation

struct GameState {
    
    var sequence: [Int] = []
    var currentIndex: Int? = nil
    var eventNumber: Int = 0
    var correctResponses: Int = 0
    var currentLetter: String? = nil
    var isRunning: Bool = false
    var highScore: Int = UserDefaults.standard.integer(forKey: "NBackHighScore")
    var hasMatchedCurrentEvent: Bool = false
}
