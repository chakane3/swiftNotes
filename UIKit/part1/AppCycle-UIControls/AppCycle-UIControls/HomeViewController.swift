//
//  ViewController.swift
//  AppCycle-UIControls
//
//  Created by Chakane Shegog on 9/16/23.
//

import UIKit

class HomeViewController: UIViewController {

    // 1. This is like our initializer. Its called when the app first launches (when the view controller is presented to the user)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("HomeViewController - viewDidLoad()")
    }
    
    // 2. This this called when you land on a view
    // For example If this is view A and we have a view B; everytime we navigate back to view A this function will be called.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("HomeViewController - viewWillAppear")
    }
    
    // 3
    // This function gets called when the view has finished "appearing"
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("HomeViewController - viewDidAppear")
    }
    
    // 4
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("HomeViewController - viewWillDisappear")
    }
    
    // 5
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("HomeViewController - viewDidDisappear")
    }


}

