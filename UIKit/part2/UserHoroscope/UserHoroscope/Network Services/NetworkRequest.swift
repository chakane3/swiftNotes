//
//  NetworkRequest.swift
//  UserHoroscope
//
//  Created by Chakane Shegog on 1/21/22.
//

import Foundation

enum NetworkErrors: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}

public class NetworkRequest {
    public static let shared = NetworkRequest()
    private var urlSession: URLSession
    
    // initializes this class as a private ensures that nobody can create an instance of this class outside this file
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, NetworkErrors>) -> ()) {
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            // check for network client error
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            // downcast our URLResponse (response) to HTTPURLResponse to get access to the statuscode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // validate that the statusCode is in the 200 range
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
