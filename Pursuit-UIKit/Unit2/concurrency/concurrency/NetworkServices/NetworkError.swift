//
//  NetworkError.swift
//  concurrency
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation

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
        case .noData: return "no data"
        case let .badURLResponse(statusCode): return "Bad status code: \(statusCode)"
        }
    }
}
