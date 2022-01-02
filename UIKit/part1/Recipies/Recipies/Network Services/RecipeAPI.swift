//
//  RecipeAPI.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation

struct RecipeAPI {
    
    // this function takes in a search query of type string. This is what the user will enter in.
    // It uses a completion handler to handle the network request as we compile our data
    static func fetchRecipe(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError>) -> ()) {
        
        // enables urls to have spaces
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "or not"
        
        let recipeEndpoint = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appID)&app_key=\(SecretKey.appKey)&from0&to=50"
        
        guard let url = URL(string: recipeEndpoint) else {
            completion(.failure(.badURL(recipeEndpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(RecipeSearch.self, from: data)
                    
                    // at this point we have the data that we need
                    // we use our search results to create an array of recipies
                    // we use "map" to transform our hits array into a [recipes] array
                    // this is another example of a closure
                    let recipes = searchResults.hits.map {$0.recipe}
                    
                    // capture the array of recipes in the completion handler
                    completion(.success(recipes))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
