//
//  ViewController.swift
//  appLifeCycle
//
//  Created by Chakane Shegog on 12/5/21.
//

import UIKit

class homeViewController: UIViewController {
    
    /*
        This is called when the controllers content view is created and loaded from a storyboard.
     
        iOS usually only calls this once, when the content view is created.
     
        We use this to perform any additional setup rerquired by our view, such as loadData,
        setting protocol extensions to self, updating UI.
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        print("homeViewController - viewDidLoad")
    }
    
    
    /*
        This is called before the view controller's content is added to the app's view hierarchy.
     
        This method is used to trigger any operations that need to occur before
        the content view is presented onscreen.
     
        This method ultimately indicates that the content view is "about" to be added to the apps
        view hierarchy and doesnt mean that something will appear at this function.
    */
    override func viewWillAppear(_ animated: Bool) {
        print("homeViewController - viewWillAppear")
    }


}

