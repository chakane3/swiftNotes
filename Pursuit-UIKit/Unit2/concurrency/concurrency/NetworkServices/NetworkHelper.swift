//
//  NetworkHelper.swift
//  concurrency
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation
class NetworkHelper {
    static let manager = NetworkHelper()
    
    
    // this function takes in a string as a URL
    // this also has a closure of type: (Result<Data, NetworkError>) -> Void
    // Result is a built in enum in swift which represents .success or .failure as an associated value
    // We'll take in the URL, then call the completion handler passing in data or return a network error
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.responseError(error)))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
    
    // URLSession is a swift class that lets us create a connection to a URL.
    // We use its dataTask(with:completetionHandler:) which takes in a closure of type:
    // (Data?, URLResponse?, Error?) -> Void
    // Data represents the raw data we get back from the URL
    // URLResponse is an HTTPURLResponse that gives back a status code of a request we made
//    If anything goes wrong; sich as internet being down, wrong url, etc. We'll use a completion handler
    // If everything goes right, we will also use the completion handler to pass us the data we need.
    private let urlSession = URLSession(configuration: .default)
    private init() {}
}
