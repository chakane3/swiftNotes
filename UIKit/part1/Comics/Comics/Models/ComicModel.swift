//
//  ComicModel.swift
//  Comics
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation

struct Comics: Codable {
    let safe_title: String
    let img: String
    let title: String
}

extension Comics {
    // 2563 represents today (Monday Jan 2, 2022)
    static func fetchComic(for day: Int, completionHandler: @escaping (Result<Comics, AppError>) -> ()) {
        let endpoint = "https://xkcd.com/\(day)/info.0.json"
        
        // turn our endpoint into a URL and send it as a request to our URLSession wrapper
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
    
        
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let networkError):
                completionHandler(.failure(networkError))
                
            case .success(let data):
                do {
                    let comics = try JSONDecoder().decode(Comics.self, from: data)
                    completionHandler(.success(comics))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
