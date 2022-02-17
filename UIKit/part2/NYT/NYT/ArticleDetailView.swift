//
//  ArticleDetailView.swift
//  NYT
//
//  Created by Chakane Shegog on 2/17/22.
//

import UIKit



class ArticleDetailView: UIView {
    // create image view
    public lazy var newsImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // create abstract headline
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Abstract Headline"
//        label.textAlignment = center
        return label
    }()
    
    // create byline
//    public lazy var newsByLine: UILabel = {
//
//    }()
    
    // date
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupNewsImageViewConstraints()
        setupAbstractHeadlineConstraints()
    }
    
    // MARK: - create constraints
    private func setupNewsImageViewConstraints() {
        addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func setupAbstractHeadlineConstraints() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractHeadline.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abstractHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
