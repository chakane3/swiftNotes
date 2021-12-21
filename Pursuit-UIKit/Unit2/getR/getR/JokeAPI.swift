//
//  JokeAPI.swift
//  getR
//
//  Created by Chakane Shegog on 12/21/21.
//

import Foundation

class JokeAPI {
    static let manager = JokeAPI()
    
    func getJokes(completionHandler: @escaping (Result<[Joke], JokeError>) -> Void) {
        NetworkHelper.manager.getData(from: jokesEndpoint) { (result) in
            switch result {
            case let .success(data):
                do {
                    let jokes = try JSONDecoder().decode([Joke].self, from: data)
                    completionHandler(.success(jokes))
                } catch {
                    completionHandler(.failure(.jsonDecodingError(error)))
                }
            case let .failure(NetworkError):
                completionHandler(.failure(.networkError(NetworkError)))
            }
        }
    }
    
    // private properties
    private let jokesEndpoint = "https://v2.jokeapi.dev/joke/Programming?type=twopart&amount=10"
    private init() {}
}
