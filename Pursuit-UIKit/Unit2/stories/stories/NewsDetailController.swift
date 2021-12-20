//
//  NewsDetailController.swift
//  stories
//
//  Created by Chakane Shegog on 12/19/21.
//

import UIKit

class NewsDetailController: UIViewController {
    @IBOutlet weak var headlinesImageView: UIImageView!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var headlineAbstractLabel: UITextView!
    
    var newsHeadline: NewsHeadline?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        guard let headline = newsHeadline else {
            fatalError("nil found, check prepare for segue")
        }
        navigationItem.title = headline.title
        headlineAbstractLabel.text = headline.abstract
        bylineLabel.text = headline.byline
        
        // update image
        if let superJumboImage = headline.superJumbo {
            // add an ImageClient to handle our request for an image using an url
            ImageClient.fetchImage(for: superJumboImage.url) { (result) in
                switch result {
                case .failure(let error):
                    print("error: \(error)")
                    
                case .success(let image):
                    DispatchQueue.main.async {
                        self.headlinesImageView.image = image
                    }
                }
            }
        }
    }
}
