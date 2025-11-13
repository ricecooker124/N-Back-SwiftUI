//
//  N_Back_SwiftUIModel.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-09-19.
//

import Foundation

struct N_BackSwiftUIModel {
    private var count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    func getHighScore() -> Int {
        return count
    }
    
    mutating func addScore() {
        count += 1
    }
    
    mutating func resetNback() {
        let nback = create(20, 9, 20, 2)
        for i in 1...3 {
            let index = Int32(i)
            print("aValue: \(getIndexOf(nback, index))")
        }
    }
    
    mutating func generateSequence(length: Int, combinations: Int, matchPercentage: Int, nback: Int) -> [Int] {
        let s = create(Int32(length), Int32(combinations), Int32(matchPercentage), Int32(nback))
        
        var result: [Int] = []
        result.reserveCapacity(length)
        
        for i in 0..<length {
            result.append(Int(getIndexOf(s, Int32(i))))
        }
        return result
    }
}
