//
//  JokeModel.swift
//  getR
//
//  Created by Chakane Shegog on 12/21/21.
//

import Foundation

struct Jokes: Codable {
    let jokes: [Joke]
}

struct Joke: Codable {
    let id: Int
    let type: String
    let setup: String
    let delivery: String
}
