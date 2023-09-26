//
//  GuessingGameModel.swift
//  GuessingGame
//
//  Created by Chakane Shegog on 9/11/23.
//

import Foundation

enum GuessOutcome {
    case incorrect
    case correct
}

class GuessingGameModel {
    let winningNum: Int
    
    init() {
        winningNum = Int.random(in: 18...21)
    }
    
    func gameResult(_ userNum: Int) -> GuessOutcome {
        if userNum != winningNum {
            return GuessOutcome.incorrect
        } else {
            return GuessOutcome.correct
        }
    }
}
