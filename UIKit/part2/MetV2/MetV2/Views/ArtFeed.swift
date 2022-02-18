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
        butt.titleLabel?.textColor = .white
        return butt
    }()
    
    // create a UIImage (in behind the uiview)
    public lazy var artImage: UIImageView = {
        let ai = UIImageView()
        ai.image = UIImage(systemName: "photo")
        ai.contentMode = .scaleAspectFill
        return ai
    }()
    
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
        setupImageConstraints()
    }
    
    // MARK: - Constraints for UI objects
    private func setupButtonConstraints() {
        addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
            generateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            generateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90)
        ])
    }
    
    private func setupImageConstraints() {
        addSubview(artImage)
        artImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artImage.topAnchor.constraint(equalTo: topAnchor),
            artImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            artImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            artImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
