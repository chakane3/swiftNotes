//
//  TopStoriesTabBarController.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import UIKit

class TopStoriesTabBarController: UITabBarController {
    private lazy var newsFeedVC: NewsFeed = {
        let viewController = NewsFeed()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticles = {
        let viewController = SavedArticles()
        viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
        return viewController
    }()
    
    private lazy var settingsVC: Settings = {
        let viewController = Settings()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        viewControllers = [newsFeedVC, savedArticlesVC, settingsVC]
    }

}
