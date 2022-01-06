//
//  ViewController.swift
//  CollectionView
//
//  Created by Chakane Shegog on 1/2/22.
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

