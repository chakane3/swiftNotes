//
//  NewsCell.swift
//  NYT
//
//  Created by Chakane Shegog on 1/24/22.
//

import UIKit

class NewsCell: UICollectionViewCell {
    // articles image view
    public lazy var newsImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.backgroundColor = .systemOrange
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // article title
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article Title"
        return label
    }()
    
    // article abstract
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract Headline"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupNewsImageViewConstraints()
        setupArticleTitleconstraints()
        setupAbstractHeadlineConstraints()
    }
    
    private func setupNewsImageViewConstraints() {
        addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            // newImageView.trailingAnchor.constraint(equalTo: )
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor)
        ])
    }
    
    
    private func setupArticleTitleconstraints() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: newsImageView.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupAbstractHeadlineConstraints() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractHeadline.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstractHeadline.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor),
            abstractHeadline.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8)
        ])
    }
    
    public func configureCell(with article: Article) {
        articleTitle.text = article.title
        abstractHeadline.text = article.abstract
        
        // we have different image sizes (superJumbo -> 2048 x 1365), (thumbLarge -> 150 x 150)
        newsImageView.getImage(with: article.getArticleImageURL(for: .thumbLarge)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.newsImageView.image = image
                }
            }
        }
    }
}
