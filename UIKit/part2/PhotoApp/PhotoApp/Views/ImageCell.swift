//
//  ImageCellDelegate.swift
//  PhotoApp
//
//  Created by Chakane Shegog on 1/9/22.
//

import UIKit

//  (1) define the protocol for our custom delegation
protocol ImageCellDelegate: AnyObject {
    
    // the required function for our protocol
    // we do a longPress so that when the user long presses a photo, we have a subview for deleting a photo
    func didLongPress(_ imageCell: ImageCell)
}


class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    // (2) define optional delegate variable
    weak var delegate: ImageCellDelegate?
    
    // setup long press gesure recognizer
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0 // makes our image appear rounded
        backgroundColor = .orange
        
        // added gesture to the view
        addGestureRecognizer(longPressGesture)
        
    }
    
    // this function gets called when long press is activated
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        // (3) explicitly use delegate object to notify of any updates, i.e notifying the ImageViewController when the user long presses on the celll
        delegate?.didLongPress(self)
    }
    
    public func configureCell(imageObject: ImageObject) {
        // converting Data to UIImage
        guard let image = UIImage(data: imageObject.imageData) else {
            return
        }
        imageView.image = image
    }
}
