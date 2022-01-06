//
//  NetworkRequest.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/5/22.
//

import Foundation

public class NetworkRequest {
    // this creates a shared instance of network helper
    public static let shared = NetworkRequest()
    private var urlSession: URLSession
    
    // initializing this class as a private ensures that nobody can create an instance of this class outside this file
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    
    public func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            // check for client network error
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            // downcast URLResponse (response) to HTTPURLResponse to get access to the statusCode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // validate that the status code is in the 200 range
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


public enum AppError: Error, CustomStringConvertible {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
    
    public var description: String {
        switch self {
        case .decodingError(let error):
            return "\(error)"
            
        case .badStatusCode(let code):
            return "Bad status code of \(code) returned from web API"
            
        case .encodingError(let error):
            return "encoding error: \(error)"
            
        case .networkClientError(let error):
            return "network error: \(error)"
            
        case .badURL(let url):
            return "\(url) is a bad url"
            
        case .noData:
            return "no data was returned from the web API"
            
        case .noResponse:
            return "no response was returned from the web API"
            
        case .badMimeType(let mimeType):
            return "verify your mime type. Found a \(mimeType) mime type"
        }
    }
}
