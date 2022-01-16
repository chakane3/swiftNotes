//
//  PixabayAPI.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/15/22.
//

import Foundation

struct PixabayAPI {
    
    // we take in the users searchQuery as input and use a completion handler to handle our network request
    static func fetchPhotos(for searchQuery: String, completion: @escaping (Result<[Hits], NetworkErrors>) -> ()) {
        // addingPercentEncoding() allows the searchQuery to have spaces
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "or not"
        
        let photosEndpoint = "https://pixabay.com/api/?key=\(SecretKey.appKey)&q=\(searchQuery)"
        
        // perform the networkRequest
        NetworkRequest.shared.getData(from: photosEndpoint) { (result) in
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(Photos.self, from: data)
                    completion(.success(searchResults.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
