//
//  NetworkRequest.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/15/22.
//

import Foundation

enum NetworkErrors: Error {
    case decodingError(Error)
    case noData
    case networkClientError(Error)
    case badStatusCode(Int)
    case badURL
    case badURLResponse(Int)
    case noURLReponse
}

public class NetworkRequest {
    
    // we want to use a singleton design pattern on our class so that this shared instance can be used throughout the app without interfering with any other properties inside this class
    public static let shared = NetworkRequest()
    private var session: URLSession
    
    // private marks this class to be initiated only in this file
    private init() {
        session = URLSession(configuration: .default)
    }
    
    // here we take in a String which serves as our URL to make this network request
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkErrors>) -> Void) {
        
        // check if we have a valid url
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        // we use the URLSession's dataTask to make the network request and get back some data
        // the input here is url of type URL
        let dataTask = self.session.dataTask(with: url) { (data, response, error) in
            
            // network client error
            if let error = error {
                completionHandler(.failure(.networkClientError(error)))
                return
            }
            
            // this gives us back a URLResponse for our network request
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLReponse))
                return
            }
            
            // check URLResponse to see if were in the 200 range
            switch urlResponse.statusCode {
            case 200...299: break
            default: completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            
            //  property to hold our data
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            //capture our data
            completionHandler(.success(data))
        }
        dataTask.resume() // finish the network request
    }
}
