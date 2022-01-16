//
//  ImageClient.swift
//  stories
//
//  Created by Chakane Shegog on 12/19/21.
//

import Foundation
import UIKit

struct ImageClient {
    // this is an escaping closure, the function will return before the closure gets a value
    static func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        // the completion captures the image () -> () for this example "Takes in a result, does nothing"
        
        // check if we have a valid url
        guard let url = URL(string: urlString) else {
            print("bad url \(urlString)")
            return
        }
        
        // create a data task using the URLSession()
        // were implementing an asynchronous network call here
        let dataTask = URLSession.shared.dataTask(with: url) {
            (data, response, error) in // this is a trailing closure
            
            // check for errors
            if let error = error {
                print("error: \(error)")
            }
            
            // check function definition
            if let data = data {
                // use data to make an image
                let image = UIImage(data: data)
                
                // then use a completion handler to capture the result of the image
                completion(.success(image))
            }
        }
        dataTask.resume() // this invokes the network request
    }
}
