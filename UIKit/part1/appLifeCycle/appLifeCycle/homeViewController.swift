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
        print("homeViewController - viewWillAppear", "isAnimated: \(animated)")
    }
    
    /*
        This function is called after the VC's content view has been added to the apps
        view hierarchy.
     
        We use this method to trigger operations that need to occur as soon as the view is presented onscreen,
        such as fetching data or showing animation.
     
        Ultimately this view indicates that the content view has been added to the apps hierarchy
        and does not mean that the content view is visible.
    */
    override func viewDidAppear(_ animated: Bool) {
        print("homeViewController - viewDidAppear", "isAnimated: \(animated)")
    }
    
    
    /*
        This function is called just before the content view is removed from the app's view hierarchy.
     
        We use this method to perform cleanup tasks like comitting changes or resigning the first
        responder status.
     
        This method is only called when the content view is "about" to be removed from the apps
        view hierarchy.
    */
    override func viewWillDisappear(_ animated: Bool) {
        print("homeViewController - viewWillDisappear", "isAnimated: \(animated)")
    }
    
    /*
        This function is called after the view controller's content view has been removed from the apps view hierarchy.
     
        We use this method to perform additional teardown activities.
    */
    override func viewDidDisappear(_ animated: Bool) {
        print("homeViewController - viewDidDisappear", "isAnimated: \(animated)")
    }
    
    
    // This function may get called multiple times
    override func viewWillLayoutSubviews() {
        print("homeViewController - willLayoutSubviews")
    }

}

