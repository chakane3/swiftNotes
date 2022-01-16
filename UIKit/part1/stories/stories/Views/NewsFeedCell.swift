//
//  NewsFeedCell.swift
//  stories
//
//  Created by Chakane Shegog on 1/16/22.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    
    var newsArticle: [NewsHeadline]?
    
    func configureCell(for article: NewsHeadline) {
        titleLabel.text = article.title
        bylineLabel.text = article.byline
        
        // get our image
        if let thumbImage = article.thumbImage {
            // unowned self guarantees that the image will be present
            ImageClient.fetchImage(for: thumbImage.url) { [unowned self] (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.storyImage.image = image
                    }
                case .failure(let error):
                    print("configureCell image error - \(error)")
                }
            }
        }
    }
}
