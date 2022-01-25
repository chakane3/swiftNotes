//
//  NewsFeed.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import UIKit

class NewsFeedController: UIViewController {
    private let newsFeedView = NewsFeed()
    
    // data for our collection view
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // setting up collectionview data source and delegate
        newsFeedView.collectionView.dataSource = self
        newsFeedView.collectionView.delegate = self
        
        // register a collection view cell
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        fetchStories()
    }
    
    private func fetchStories(for section: String = "Technology") {
        NYTTopStoriesAPIClient.fetchTopStories(for: section) { (result) in
            switch result {
            case .failure(let networkError):
                print("error fetching stories: \(networkError)")
            case .success(let data):
                self.newsArticles = data
            }
        }
    }
}

extension NewsFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    // return item size
    // item height ~ 30% of height of device
    // itemWidth ~ 100% of width of device
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.30 // 30%
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
