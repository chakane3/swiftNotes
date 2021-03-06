//
//  TopStoriesTabBarController.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//


// Here we setup our tab bar controller
import UIKit

class TopStoriesTabBarController: UITabBarController {
    private var dataPersistence = DataPersistence<Article>(filename: "savedArticles.plist")
    
    
    private lazy var newsFeedVC: NewsFeedController = {
        let viewController = NewsFeedController()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticlesController = {
        let viewController = SavedArticlesController()
        viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
        return viewController
    }()
    
    private lazy var settingsVC: SettingsController = {
        let viewController = SettingsController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        viewControllers = [UINavigationController(rootViewController: newsFeedVC) ,
                           UINavigationController(rootViewController: savedArticlesVC),
                           UINavigationController(rootViewController: settingsVC)]
    }

}
