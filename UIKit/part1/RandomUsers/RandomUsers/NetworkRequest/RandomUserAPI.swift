//
//  RandomUserAPI.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/5/22.
//

import Foundation

struct RandomUsersAPI {
    // this function will use our single endpoint for the whole app
    static func fetchRandomUsers(completion: @escaping (Result<[RandomUser], AppError>) -> ()) {
        let endpoint = "https://randomuser.me/api/?results=100"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(RandomUsers.self, from: data)
                    completion(.success(searchResults.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
