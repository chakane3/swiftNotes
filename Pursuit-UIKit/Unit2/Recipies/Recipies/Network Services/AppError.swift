//
//  AppError.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}
