//
//  RecipeModel.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation

struct RecipeSearch: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String
}
