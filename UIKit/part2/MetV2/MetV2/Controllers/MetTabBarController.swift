//
//  MetTabBarController.swift
//  MetV2
//
//  Created by Chakane Shegog on 1/29/22.
//

import UIKit

class MetTabBarController: UITabBarController {
    
    private lazy var artFeedVC: ArtFeedController = {
       let viewController = ArtFeedController()
        viewController.tabBarItem = UITabBarItem(title: "Art Feed", image: UIImage(systemName: "paintpalette"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArtVC: SavedArtController = {
        let viewController = SavedArtController()
        viewController.tabBarItem = UITabBarItem(title: "Saved art", image: UIImage(systemName: "folder"), tag: 1)
        return viewController
    }()
    
    private lazy var settingsVC: SettingsController = {
       let viewController = SettingsController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewControllers = [artFeedVC, savedArtVC, settingsVC]
    }
}
