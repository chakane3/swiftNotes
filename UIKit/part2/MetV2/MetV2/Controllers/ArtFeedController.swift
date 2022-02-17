//
//  ArtFeedController.swift
//  MetV2
//
//  Created by Chakane Shegog on 1/29/22.
//

import UIKit

class ArtFeedController: UIViewController {
    private let artFeedView = ArtFeed()
    
    override func loadView() {
        view = artFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
}
