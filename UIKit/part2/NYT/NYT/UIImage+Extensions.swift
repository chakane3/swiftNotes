//
//  UIImage+Extensions.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import Foundation
import UIKit

extension UIImageView {
    // saves image data to the caches directory
    private func write(to directory: Directory, image: UIImage, path: String) {
        let directoryURL = directory == .cachesDirectory ? FileManager.getCachesDirectory() : FileManager.getDocumentsDirectory()
        let filepath = directoryURL.appendingPathComponent(path)
        
        // convert images to data (png or jpg)
        let imageData = image.pngData()
        
        // write to caches directory
        try? imageData?.write(to: filepath)
    }
    
    // retrieves and image from the caches directory
    public func cachedImage(for filename: String, directory: Directory = .cachesDirectory) -> UIImage? {
        let directoryURL = directory == .cachesDirectory ? FileManager.getCachesDirectory() : FileManager.getDocumentsDirectory()
        let filepath = directoryURL.appendingPathComponent(filename)
        guard FileManager.default.fileExists(atPath: filepath.path) else {
            return nil
        }
        guard let data = FileManager.default.contents(atPath: filepath.path) else {
            return nil
        }
        let image = UIImage(data: data)
        return image
    }
    
    // instance method on a UIImageView gets an image from the caches directory or the network
    public func getImage(with urlString: String, writeTo directory: Directory = .cachesDirectory, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        
        // use UIActivityIndicatorView to indicate to the user that a download is in progress
        var activityIndicator: UIActivityIndicatorView!
        DispatchQueue.main.async {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = UIColor.systemOrange
            activityIndicator.startAnimating()
            self.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
            return
        }
        
        // check the cache
        let filename = createComponentString(from: url)
        if let cachedImage = cachedImage(for: filename, directory: directory) {
            completion(.success(cachedImage))
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
            return
        }
        let request = URLRequest(url: url)
        
        NetworkRequest.shared.performDataTask(with: request) { [weak activityIndicator, weak self] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            switch result {
            case .failure(let networkError):
                completion(.failure(.networkClientError(networkError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    // cache image to disk
                    let componentStr = self?.createComponentString(from: url) ?? ""
                    self?.write(to: directory, image: image, path: componentStr)
                    completion(.success(image))
                }
            }
        }
    }
    
    private func createComponentString(from url: URL) -> String {
        var componentStr = ""
        for component in url.pathComponents where component != "/" {
            componentStr += component
        }
        return componentStr
    }
}



