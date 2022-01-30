//
//  NetworkRequest.swift
//  MetV2
//
//  Created by Chakane Shegog on 1/29/22.
//

import Foundation

public enum NetworkError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}

private struct CacheKey {
    static let lastModifiedDate = "Last Modified Cache Date"
}

public class NetworkRequest {
    public static let shared = NetworkRequest()
    private var urlSession: URLSession
    private var isCaching = true
    
    // asserts a singleton design pattern
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    
    private func verifyCacheDate(for lastModifiedTimeInterval: TimeInterval, maxCacheDays: Int) {
        // create 2 Date() objects from TimeIntervals
        let lastModifiedDate = Date(timeIntervalSince1970: lastModifiedTimeInterval)
        let todaysDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        
        // get an instance of the users calendar
        let calendar = Calendar.current
        
        // get the difference between 2 Date() objects
        let components = calendar.dateComponents([.day], from: lastModifiedDate, to: todaysDate)
        
        // extract the day value from the DateComponent
        let differenceInDates = components.day ?? 0
        
        // clear the urlCache if the maxCacheDays has expired
        if differenceInDates >= maxCacheDays {
            urlSession.configuration.urlCache?.removeAllCachedResponses()
            isCaching = false
        }
    }
    
    
}
