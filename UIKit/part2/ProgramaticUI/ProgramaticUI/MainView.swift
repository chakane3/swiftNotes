//
//  MainView.swift
//  ProgramaticUI
//
//  Created by Chakane Shegog on 1/15/22.
//

import UIKit

class MainView: UIView {
    let defaultMessage = "No default color set. Please go to settings"
    // create a label
    // lazy makes it so that this property gets instantiated when the MainView instance gets created
    // lazy guarantees the appropriate instance exists before the body gets executed.
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = defaultMessage
        return label
        
    }() // () creates a closure and calls simultaneously
    
    
    // create a button
    
    // we need to give our view some frame
    // this intiailizer gets called if the view is done, programmatically
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    // this comes from storyboard
    // if this view gets initialized from storyboard
    // the intiailizer gets called below
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {}
}

