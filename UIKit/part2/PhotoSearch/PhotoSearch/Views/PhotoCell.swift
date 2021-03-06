//
//  PhotoCell.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/15/22.
//

import UIKit
import AVFoundation

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photosView: UIImageView!
    
    // define our optional delegate variable
    weak var delegate: ImageCellDelegate?
    
    // setup long press gesture recognizer
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    var photo: [Hits]?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0
        addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        
        // use our delegate object to notify the view of any updates (whenever the user presses on the cell)
        delegate?.didLongPress(self)
    }
    
    func configureCell(for photo: Hits) {
        photosView.getImage(with: photo.webformatURL) { (result) in
            switch result {
            case .failure(let imageError):
                print("error obtaining image: \(imageError)")
            case .success(let data):
                DispatchQueue.main.async { [self] in
                    self.photosView.image = data
                    let size = UIScreen.main.bounds.size
                    let rect = AVMakeRect(aspectRatio: photosView.image?.size ?? CGSize(width: 50, height: 50), insideRect: CGRect(origin: CGPoint.zero, size: size))
                    let resizeImage = photosView.image?.resizeImage(to: rect.size.width, height: rect.size.height)
                    guard let resizedImageData = resizeImage?.jpegData(compressionQuality: 1.0) else {
                        return
                    }

                    self.photosView.image = UIImage(data: resizedImageData)
                }
            }
        }
    }
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
