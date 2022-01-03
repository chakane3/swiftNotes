//
//  ImageCell.swift
//  BasicIG
//
//  Created by Chakane Shegog on 1/2/22.
//

import Foundation
import UIKit

// create custom delegation: define the protocol
protocol ImageCellDelegate: AnyObject {
    func didLongPress(_ imageCell: ImageCell)
}

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    // define optional delegate variable
    weak var delegate: ImageCellDelegate?
    
    // setup long press gesture recognizer
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0
        backgroundColor = .orange
        
        // add longpress gesture to our view
        addGestureRecognizer(longPressGesture)
    }
    
    // long press setup
    // this function gets called when long press is activated
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        
        // use delegate object to notify of any updates
        // i.e Notifying the ImageViewController when the user long presses on the cell
        delegate?.didLongPress(self)
    }
    
    public func configureCell(imageObject: ImageObject) {
        // convert data to UIImage
        guard let image = UIImage(data: imageObject.imageData) else {
            return
        }
        imageView.image = image
    }
}
