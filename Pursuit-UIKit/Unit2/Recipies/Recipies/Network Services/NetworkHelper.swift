//
//  NetworkHelper.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation

// this is a different implementation of our URLSession wrapper (check github network request part 1)
class NetworkHelper {
    // singleton - this creates a shared instance of the network helper
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we create a private initializer to prevent our instance of URLSession to be used outside this file.
    private init() {
        session = URLSession(configuration: .default)
    }
    
    // This function takes in a request of type URLRequest
    // Theres a closure of type: (Result<Data, AppError>) -> ())
    // Result is a built in enum in swift which represents .success or .failure as an associated value
    // We'll take in the URL, then call the completion handler passing in data or return a app error/ network error
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // check for network client error
            if let error = error  {
                completion(.failure(.networkClientError(error)))
            }
            
            // downcast URLResponse (response) to HTTPURLResponse to get
            // access to the statusCode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap out data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // check our status code
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            // if nothing went wrong, capture our data
            completion(.success(data))
        }
        dataTask.resume()
    }
}
