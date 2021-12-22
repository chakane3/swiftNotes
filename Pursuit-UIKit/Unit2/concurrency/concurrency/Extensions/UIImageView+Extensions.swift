//
//  UIImageView+Extensions.swift
//  concurrency
//
//  Created by Chakane Shegog on 12/22/21.
//

import UIKit

extension UIImageView {
    // instance method
    func setImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        
        // configure UIActivityIndicatorView
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = center
        addSubview(activityIndicator) // add UIActivityIndicatorView to the UIImageView
        activityIndicator.startAnimating()  // begin animation
        
        // use network helper to grab our image or check for errors
        // [weak activityIndicator] is a capture list to break any strong reference cycles.
        NetworkHelper.manager.getData(from: urlString) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
