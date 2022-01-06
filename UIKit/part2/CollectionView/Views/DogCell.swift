//
//  DogCell.swift
//  CollectionView
//
//  Created by Chakane Shegog on 1/3/22.
//

import UIKit

class DogCell: UICollectionViewCell {
    @IBOutlet weak var dogImageView: UIImageView!
    
    public func configureCell(with dogImage: DogImage) {
        dogImageView.getImage(with: dogImage) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.dogImageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.dogImageView.image = image
                }
            }
        }
    }
}
