//
//  NewsFeed.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import UIKit

class NewsFeedController: UIViewController {
    private let newsFeedView = NewsFeed()
    
    override func loadView() {
        view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // setting up collectionview data source and delegate
        newsFeedView.collectionView = self
//        newsFeedView.searchBar = self
    }
}

extension NewsFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath)
        return cell
    }
    
}

extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    // return item size
    // item height ~ 30% of height of device
    // itemWidth ~ 100% of width of device
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
    }
    
}
