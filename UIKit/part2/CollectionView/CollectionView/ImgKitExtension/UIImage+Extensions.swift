//
//  UIImage+Extensions.swift
//  CollectionView
//
//  Created by Chakane Shegog on 1/2/22.
//

import Foundation
import UIKit


extension UIImageView {
    
    // this is an instance method on a UIImageView which gets an image from the network
    public func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        // implement a UIActivityIndicatorView to indicate that a download is in progress
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.systemOrange
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor), activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            activityIndicator.stopAnimating()
            return
        }
        
        
        let request = URLRequest(url: url)
        
        NetworkRequest.shared.performDataTask(with: request) { [weak activityIndicator, weak self] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(data))
                }
            }
        }
    }
}
