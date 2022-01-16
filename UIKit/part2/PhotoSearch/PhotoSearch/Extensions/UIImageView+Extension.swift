//
//  UIImageView+Extension.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/15/22.
//

import Foundation
import UIKit


// setup an extension on UIImageView to add a funtion to use our NetworkRequest o download an image
extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkErrors>) -> ()) {
        
        // implement a UIActivityIndicatorView to indicate that a download is in progress
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.systemGray2
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // add constraints to our subview
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor), activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        NetworkRequest.shared.getData(from: urlString) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
            case .success(let data):
                if let img = UIImage(data: data) {
                    completion(.success(img))
                }
            }
        }
    }
}
