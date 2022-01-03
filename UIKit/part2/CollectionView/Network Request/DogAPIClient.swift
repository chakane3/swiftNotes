//
//  DogAPIClient.swift
//  CollectionView
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation

struct DogAPIClient {
    static func fetchDogs(completion: @escaping (Result<[DogImage], AppError>) -> ()) {
        let endpoint = "https://dog.ceo/api/breeds/image/random/50"
        
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
                    let results = try JSONDecoder().decode(DogInfo.self, from: data)
                    completion(.success(results.message))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
