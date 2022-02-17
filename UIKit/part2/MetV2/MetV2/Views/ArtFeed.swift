//
//  ArtFeed.swift
//  MetV2
//
//  Created by Chakane Shegog on 2/16/22.
//

import UIKit

class ArtFeed: UIView {
    // MARK: - Create UI objects
    // create a button
    public lazy var generateButton: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .blue
        butt.layer.opacity = 0.70
        butt.titleLabel?.text = "art me"
        return butt
    }()
    
    // create a UIImage (in behind the uiview)
    //
    
    // MARK: - Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupButtonConstraints()
        
    }
    
    // MARK: - Constraints for UI objects
    private func setupButtonConstraints() {
        addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            generateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            generateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

}
