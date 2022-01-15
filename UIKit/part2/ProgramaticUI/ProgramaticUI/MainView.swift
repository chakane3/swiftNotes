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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
        
    }() // () creates a closure and calls simultaneously
    
    
    // create a button
    public lazy var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
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
    
    private func commonInit() {
        setupLabelConstraints()
        setupResetButtonConstraints()
        
    }
    
    private func setupLabelConstraints() {
        // add the messageLabel to the MainView
        addSubview(messageLabel) // this returns the messageLabel we made above
        
        // we need to set the constraints for the message label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false // we assert that were using autolayout
        
        // this is how we set out contraints for the label
        NSLayoutConstraint.activate([
            
            // Set the top Anchor 20 points from the safe area
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            // set padding at the leading edge of the MainView
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            // set padding at the trailing edge of the Mainview
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
    }
    
    private func setupResetButtonConstraints() {
        addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        // set constraints
//        resetButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor), resetButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40)
        ])
    }
}

