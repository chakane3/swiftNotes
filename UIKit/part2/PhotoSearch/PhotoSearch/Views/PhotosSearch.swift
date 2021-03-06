//
//  PhotosSearch.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/15/22.
//

import UIKit

class PhotosSearch: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [Hits]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var searchQuery = "" {
        didSet {
            searchPhotosQuery(for: searchQuery)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
    }
    
    func searchPhotosQuery(for userQuery: String) {
        PixabayAPI.fetchPhotos(for: userQuery) { (result) in
            switch result {
            case .failure(let networkError):
                print("Network error: \(networkError)")
            case .success(let data):
                self.photos = data
            }
        }
    }
}

extension PhotosSearch: UICollectionViewDataSource {
    
    // how many cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // what goes inside the cell?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("Could not downcast to an PhotoCell")
        }
        let photo = photos[indexPath.row]
        cell.configureCell(for: photo)
        return cell
    }
}

extension PhotosSearch: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.9
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosSearch: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchPhotosQuery(for: "")
            return
        }
        searchQuery = searchText
    }
}

// MARK: -ImagePickerControllerDelegate & UINNavigationControllerDelegate
extension PhotosSearch: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selected not found")
            return
        }
        dismiss(animated: true)
    }
}


// MARK: - ImageCellDelegate (custom protocol for longPress)
extension PhotosSearch: ImageCellDelegate {
    func didLongPress(_ photoCell: PhotoCell) {
        
        // grab our index pat for the cell
//        guard let indexPath = collectionView.indexPath(for: photoCell) else {
//            return
//        }
        
        // present our action sheet
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save Photo", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

