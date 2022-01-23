//
//  NewsFeed.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import UIKit

class NewsFeed: UIView {
    
    // MARK: - Create UI objects
    // create a searchbar
    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.autocapitalizationType = .none
        sb.placeholder = "search for article"
        return sb
    }()
    
    // create a collection view
    public lazy var collectionView: UICollectionView = {
        // create flow layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .yellow
        return cv
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
        setupSearchBarConstraints()
        setupCollectionViewContraints()
    }
    
    
    // MARK: - Constraints for UI objects
    // setup constraints for searchbar
    private func setupSearchBarConstraints() {
        // 1
        addSubview(searchBar)
        
        // 2
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // 3 constrain the search bar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // setup constraints for the collectionView
    private func setupCollectionViewContraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
