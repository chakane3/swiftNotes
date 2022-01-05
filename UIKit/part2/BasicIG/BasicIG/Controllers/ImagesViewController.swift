//
//  ViewController.swift
//  BasicIG
//
//  Created by Chakane Shegog on 1/2/22.
//

import UIKit
import AVFoundation

class ImagesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var imageObjets = [ImageObject]()
    private let imagePickerController = UIImagePickerController()
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage? {
        didSet {
            appendNewPhotoToCollection() // 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func loadImageObjects() {
        do {
            imageObjets = try dataPersistence.loadItems()
        } catch {
            print("loading objects error: \(error)")
        }
    }
    
    private func appendNewPhotoToCollection() {
        guard let image = selectedImage else {
            print("image is nil")
            return
        }
        
        // the size for resizing the image
        let size = UIScreen.main.bounds.size
        
        // we will maintain the aspect ratio of the image
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        // resize image
        let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        
        //jpegData(compressionQuality: Double) -> converts UIImage to data
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        // create an ImageObject using the image selected
        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        
        // insert new image object into image objects
        imageObjets.insert(imageObject, at: 0)
        
        // create an index path for insertion into collection view
        let indexPath = IndexPath(row: 0, section: 0)
        
        // insert new cell into collection view
        collectionView.insertItems(at: [indexPath])
        
        // persist imageObject to documents directory
        do {
            try dataPersistence.create(item: imageObject)
        } catch {
            print("saving error: \(error)")
        }
    }
    
    @IBAction func addPictureButtonPressed(_ sender: UIBarButtonItem) {
        // present an "action sheet" to the user
        // actions used are camera, photo library, cancel
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] alertAction in
            self?.showImageController(isCameraSelected: false) // 2
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] alertAction in
            self?.showImageController(isCameraSelected: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // check if the users camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func showImageController(isCameraSelected: Bool) {
        // source type default will be .photoLibrary
        imagePickerController.sourceType = .photoLibrary
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
}


// MARK: - UICollectionViewDataSource
extension ImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageObjets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // (4) create custom delegation -- must have an instance of object B
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not downcast to an ImageCell")
        }
        let imageObject = imageObjets[indexPath.row]
        cell.configureCell(imageObject: imageObject)
        
        // (5) create custom delegation - set delegate object similar to tableview.delegate = self
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.80
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

// MARK: - UIImagePickerController, UINavigationControllerDelegate
extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // we need to access the UIImagePickerController.InfoKey.originlImage key to get the UIImage that was selected
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selected not found")
            return
        }
        
        selectedImage = image
        dismiss(animated: true)
    }
}

// MARK: - ImageCellDelegate
extension ImagesViewController: ImageCellDelegate {
    func didLongPress(_ imageCell: ImageCell) {
        guard let indexPath = collectionView.indexPath(for: imageCell) else {
            return
        }
    }
    
    // present an action sheet
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
//        self?.deleteImageObject(indexPath: indexPath)
//    }
//    let cancelAction UIAlertAction(title: "Cancel", style: .cancel)
//    alertController.addAction(deleteAction)
//    alertController.addAction(cancelAction)
//    present(alertController, animated: true)
}
