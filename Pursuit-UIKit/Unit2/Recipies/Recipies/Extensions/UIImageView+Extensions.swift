//
//  UIImageView+Extensions.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import Foundation
import UIKit

// we need to create an extension on UIImageView to have it implement our URLSession wrapper class

extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        // UIActivityIndicatorView is used to indicate to the user that a download is in progress
        // we do this by using a subview
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
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
