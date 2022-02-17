//
//  ArticleDetailViewController.swift
//  NYT
//
//  Created by Chakane Shegog on 2/16/22.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    // bring up an article
    public var article: Article?
    
    private let detailView = ArticleDetailView()
    
    override func loadView() {
        view = detailView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateUI()
        
        
        // add a UIBarButtonItem on the right
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }
    
    private func updateUI() {
        // unwrap the article
        guard let article = article else {
            fatalError("did not load an article")
        }
        navigationItem.title = article.title
        detailView.abstractHeadline.text = article.abstract
        detailView.newsImageView.getImage(with: article.getArticleImageURL(for: .superJumbo)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.detailView.newsImageView.image = UIImage(systemName: "exclamationmark-octogon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.newsImageView.image = image
                }
            }
        }
    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        print("save article button pressed")
    }
    

}
