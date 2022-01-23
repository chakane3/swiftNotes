//
//  NetworkRequest.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
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
    static let lastModifiedDate = "Last Modified Cached Date"
}

public class NetworkRequest {
    public static let shared = NetworkRequest()
    private var urlSession: URLSession
    private var isCaching = true
    
    // asserts single design pattern
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    
    private func verifyCacheDate(for lastModifiedTimeInterval: TimeInterval, maxCacheDays: Int) {
        // create 2 Date() objects from TimeIntervals
        let lastModifiedDate = Date(timeIntervalSince1970: lastModifiedTimeInterval)
        let todaysDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        
        // get an instance of the users caledar
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
    
    // Perform the Network Request for the given URLRequest
    public func performDataTask(with request: URLRequest, maxCacheDays: Int = 0, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        // check if the cache should be cleared based on an x amount of days since the last modified date of the saved cache
        // get cache date
        if let lastModifiedTimeInterval = UserDefaults.standard.object(forKey: CacheKey.lastModifiedDate) as? TimeInterval {
            // if expired, clear the cache
            verifyCacheDate(for: lastModifiedTimeInterval, maxCacheDays: maxCacheDays)
        }
        
        if isCaching {
            if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: request),
               let _ = cachedResponse.response as? HTTPURLResponse {
                let data = cachedResponse.data
                completion(.success(data))
                return
            }
        }
        
        // setup URLSessions dataTask()
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            // check for network client errors
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            // downcast URLResponse to HTTPURLResponse for stausCode property
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
            
            // save the last modified cache date
            let cachedDate = Date().timeIntervalSince1970
            UserDefaults.standard.set(cachedDate, forKey: CacheKey.lastModifiedDate)
            
            // capture our network data
            completion(.success(data))
        }
        dataTask.resume()
    }
}
