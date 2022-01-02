//
//  networkError.swift
//  getR
//
//  Created by Chakane Shegog on 12/21/21.
//

import Foundation

// An enum conforming to the Error protocol
// This is basically a list of things that could potentially go wrong
enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case responseError(Error)
    case noURLResponse
    case noData
    case badURLResponse(Int)

    var description: String {
        switch self {
            case .badURL: return "Invalid URL"
            case let .responseError(error): return "Response Error: \(error)"
            case .noURLResponse: return "No URLResponse"
            case .noData: return "No data"
            case let .badURLResponse(statusCode): return "Bad status code: \(statusCode)"
        }
    }
}


// helps catch errors in either our NetworkError enum, and jsonDecodingError(Error)
enum JokeError: Error, CustomStringConvertible {
    case networkError(NetworkError)
    case jsonDecodingError(Error)
    var description: String {
        switch self {
        case let .networkError(networkError):
            return "Network Error: \(networkError)"
            
        case let .jsonDecodingError(decodingError):
            return "Decoding Error: \(decodingError)"
        }
    }
}
