//
//  ViewController.swift
//  ProgramaticUI
//
//  Created by Chakane Shegog on 1/15/22.
//

import UIKit

class MainViewController: UIViewController {
    // each of our controllers have a seperate class holding our UI elements
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Programatic UI"
        // adding a UIBarButtonItem to our navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSettings(_:))) // selector reprepsents the function that will get called
    }
    
    @objc // specifies a different runtime
    private func showSettings(_ sender: UIBarButtonItem) {
        // segue to the SettingsViewController by instantianting a new VC
        let settingsVC = SettingsViewController()
        
        // pushViewController is used because since were using a navigation controller we want to oush this specific view to the top of the navigation stack.
        
        // present() -> presents modally (bottom up)
        // settingsVC.modalPresentationStyle = .overCurrentContext
        // settingsVC.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    
    
    
}

