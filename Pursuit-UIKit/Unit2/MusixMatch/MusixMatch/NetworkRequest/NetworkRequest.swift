//
//  NetworkRequest.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import Foundation

enum Errors: Error {
    case badURL
    case noData
    case decodingError(Error)
    case badURLResponse(Int)
    case responseError(Error)
    case noURLResponse
}

class NetworkRequest {
    
    // this is the only part of the file we can access outside this file.
    static let shared = NetworkRequest()
    private var session: URLSession
    
    // privatemarks this class to be initialized only in this file
    private init() {
        session = URLSession(configuration: .default)
    }
    
    
    // here we take in a url as a string to make the network request
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, Errors>) -> Void) {
        
        // check if we have a value url
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        
        // use URLSession's data task to make the network request and get back data
        // the input is our url of type URL
        let dataTask = self.session.dataTask(with: url) { (data, response, error) in
            
            // used for any errors that can occur
            if let error = error {
                completionHandler(.failure(.responseError(error)))
                return
            }
            
            // gives us back a URLResponse for our network request
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            
            // checks to URL Response to see if we have a 200 Response
            switch urlResponse.statusCode {
            case 200...299: break
            default: completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            
            // property to hold our data
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            // captures data
            completionHandler(.success(data))
        }
        dataTask.resume() // finish the network request
    }
}
