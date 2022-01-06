//
//  RandomUserCollection.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/6/22.
//

import UIKit

class RandomUserCollection: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var randomUsers = [RandomUser]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        loadData()
    }
    
    func loadData() {
        RandomUsersAPI.fetchRandomUsers {(result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
                
            case .success(let data):
                self.randomUsers = data
            }
        }
    }
}


// MARK: - UICollectionViewDataSource protocol
extension RandomUserCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? RandomUserCollectionCell else {
            fatalError("could not downcast to RandomUSerCollectionCell")
        }
        let user = randomUsers[indexPath.row]
        cell.configureCell(with: user)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RandomUserCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
