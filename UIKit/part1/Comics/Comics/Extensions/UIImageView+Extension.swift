//
//  UIImageView+Extension.swift
//  Comics
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    // this is an instance on a UIImageView which gets an image from the network
    public func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        // implement a UIActivityIndicatorView to tell the user a donwload is in progress
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.systemOrange
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor), activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            
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
