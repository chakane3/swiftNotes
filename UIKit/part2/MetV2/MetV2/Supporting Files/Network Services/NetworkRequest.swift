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
    
    /*
     1. Create 2 Date() objects from TimeIntervals
     2. Get an instance of the users calendar
     3. Get the difference between 2 Date() objects
     4. Extract the day value from the DateComponent
     5. Clear the urlCache if the maxCacheDays has expired
     */
    
    private func verifyCacheDate(for lastModifiedTimeInterval: TimeInterval, maxCacheDays: Int) {
        
        let lastModifiedDate = Date(timeIntervalSince1970: lastModifiedTimeInterval) // 1
        let todaysDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        
        let calendar = Calendar.current // 2
        
        let components = calendar.dateComponents([.day], from: lastModifiedDate, to: todaysDate) // 3
        
        let differenceInDates = components.day ?? 0  // 4
        
        if differenceInDates >= maxCacheDays {  // 5
            urlSession.configuration.urlCache?.removeAllCachedResponses()
            isCaching = false
        }
    }
    
    /* Perform network request
     1. Check if the cache should be cleared based on x amount of days since the last
     */
    public func performDataTask(with request: URLRequest, maxCacheDays: Int = 0, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        
        // 1
        if let lastModifiedTimeInterval = UserDefaults.standard.object(forKey: CacheKey.lastModifiedDate) as? TimeInterval {
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
