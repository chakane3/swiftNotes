//
//  RandomUserCollectionCell.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/6/22.
//

import UIKit

class RandomUserCollectionCell: UICollectionViewCell {
    
    // here is where we configure our cell in the collection view.
    // we only need an image and a textfield
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    public func configureCell(with user: RandomUser) {
        
        // Capture our image using the extension we made in UIImageView
        imageView.getImage(with: user.picture.medium) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: appError: \(appError)")
                
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = data
                }
            }
        }
    }
    
}
