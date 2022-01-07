//
//  ViewController.swift
//  CollectionView2
//
//  Created by Chakane Shegog on 1/6/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dogImages = [DogImage]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        fetchDogImages()
    }
    
    
    private func fetchDogImages() {
        DogAPIClient.fetchDogs { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch dog images with error: \(appError)")
                
            case .success(let dogImages):
                self?.dogImages = dogImages
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as? DogCell else {
            fatalError("could not downcast to DogCell")
        }
        let dogImage = dogImages[indexPath.row]
        cell.configureCell(with: dogImage)
        return cell
    }
}

// here we are using UICollectionViewFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let interItemSpacing: CGFloat = 10 // space between items
    let maxWidth = UIScreen.main.bounds.size.width // device's width
    let numberOfItems: CGFloat = 3 // items
    let totalSpacing: CGFloat = numberOfItems * interItemSpacing
    let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
    
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) ->  UIEdgeInsets {
    return UIEdgeInsets(top: 20, left: 10, bottom: 5, right: 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
}


