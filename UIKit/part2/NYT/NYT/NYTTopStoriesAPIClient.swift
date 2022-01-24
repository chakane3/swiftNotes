//
//  NYTTopStoriesAPIClient.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import Foundation

struct NYTTopStoriesAPIClient {
    
    static func fetchTopStories(for section: String, completion: @escaping (Result<[Article], NetworkError>) -> ()) {
        let endpointURLString = "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key="
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
            case .success(let data):
                do {
                    let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                    completion(.success(topStories.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
