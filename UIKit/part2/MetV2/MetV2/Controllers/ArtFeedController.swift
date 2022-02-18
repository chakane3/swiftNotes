//
//  ArtFeedController.swift
//  MetV2
//
//  Created by Chakane Shegog on 1/29/22.
//

import UIKit

class ArtFeedController: UIViewController {
    public var art: ArtCollection?
    private let artFeedView = ArtFeed()
    
    override func loadView() {
        view = artFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateUI()
    }
    
    func updateUI() {
//        guard let art = art else {
//            fatalError("did not load the art feed")
//        }
        
    }
    
    @objc func generateArtButtonPressed(_ sender: UIButton) {
        print("leme get some new art")
    }
    
    
}
