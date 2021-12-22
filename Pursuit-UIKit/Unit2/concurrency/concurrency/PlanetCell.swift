//
//  PlanetCell.swift
//  concurrency
//
//  Created by Chakane Shegog on 12/22/21.
//

import UIKit

class PlanetCell: UITableViewCell {
    @IBOutlet weak var planetImageView: UIImageView!
    
    // we need to keep track of the image url string by using a string variable on the cell
    private var urlString = ""
    
    // this method is called before the object is returned from the UITableView method "dequeueReuseableCell"
    // this method makes it so that instead of flickering we only see the activity window.
    override func prepareForReuse() {
        super.prepareForReuse()
        // empty out the image view
        planetImageView.image = nil
    }
    
    func configureCell(with urlString: String) {
        // set the cell's urlString
        self.urlString = urlString
        
        planetImageView.setImage(with: urlString) { result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.planetImageView.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                // this will come from a background thread
                // we'd have to dispatch back to tge main thread to update the UI
                DispatchQueue.main.async {
                    // if the cell's urlString is the same as the one being passed on from the cellForRow at, we will change the current imageView's image
                    // urlString is the argument from our configureCell method
                    if self.urlString == urlString {
                        self.planetImageView.image = image
                    }
                }
            }
        }
    }
}
