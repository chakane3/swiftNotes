//
//  NetworkRequest.swift
//  Comics
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation

public class NetworkRequest {
    // this creates an instance of network helper
    public static let shared = NetworkRequest()
    
    // URLSession is a class that provides functions for us to use when downloading/uploading  data from endpoints.
    // our apps can create 1 or more URLSession instances that coordinate data-transfer tasks.
    // tasks within a given URLSession share a common session configuration object which defines connection behavior.
    // URLSession has a singleton we normally call "shared" or "session" for basic requests. We use our "shared" session to access our URLSession
    // Theres 3 other kinds of configurations for sessions.
    // A default session acts like the shared session but we can configure it. You cal also assign a delegate to the default session to obtain data incrementally.
    // Ephemeral Session are similar to shared session but doesn write cachesm cookies, or credentials to disk.
    // Background sessions lets us perform uploads and downloads of content in the background while your app isnt running
    
    // Within a session theres tasks that transfer data as one or more NSData objects in memory.
    // Data tasks send and receive data using NSData objects. They are intended for short and interactive requests to the server
    // Upload tasks are similar to data tasks but tyey also send data and supports background uploads wile the app isnt running
    // Donwload tasks get data in the form of a file, and supports background downloads and uploads while the app isnt running
    // Websocket tasks exchange messages over TCP and TLS
    
    // Tasks in a session also share a common delegate object. This delegate is implemented to provide and obtain info when various events occur when (1) Authentification fails, (2) Data arrives from the server, (3) Data becomes available for caching
    
    // Each task you create with the session calls back to the sessions delegate using the methods defined in URLSessionTask Delegate. These callbacks can be intercepted before they reach the session delegate by populating a seperate delegate that is specific to the task.
    
    // Using URLSession is highly asynchronous. It returns data to your app in 1 of 3 ways.
    // We mainly use a completion handler block which runs when the transfer competes.
    // We could also receive callbacks to a delegate method as the transfer progresses and imediately completes after it.
    
    // Most importantly, URLSession is "thread-safe" meaning you can create sessions and tasks in any thread context..
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
