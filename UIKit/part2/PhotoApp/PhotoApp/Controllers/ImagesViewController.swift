//
//  ImagesViewController.swift
//  PhotoApp
//
//  Created by Chakane Shegog on 1/9/22.
//

import UIKit
import AVFoundation // this helps us maintain the image aspect ratio

class ImagesViewController: UIViewController {
    // MARK: - Properties and Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // an empty array of ImageObjects well use for our photos UI
    private var imageObjects = [ImageObject]()
    
    // We need an instance of a controller to present to the user when they pick the camera or photo library option
    // theyre embedded in a navigation controller
    private let imagePickerController = UIImagePickerController()
    
    private let dataPersistence = Persistence(filename: "photos.plist")
    
    // This represents the image the user had selected in the photo library or taken on camera
    private var selectedImage: UIImage? {
        didSet {
            // gets called when a new image is selected -  adds photo to UI and PropertyList
            appendNewPhotoToCollection()
        }
    }
    
    // MARK: - App LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        imagePickerController.delegate = self
        loadImageObjects()
    }
    
    // MARK: - Actions and functions
    
    // this function loads photos from the PropertyList via Persistence
    private func loadImageObjects() {
        do {
            imageObjects = try dataPersistence.loadItems()
        } catch {
            print("loading objects error: \(error)")
        }
    }
    
    private func appendNewPhotoToCollection() {
        // try to set the new user's selected image
        guard let image = selectedImage else {
            print("image is nil")
            return
        }
        print("original image size is \(image.size)")
        // here we want to: (1) Create an image object, (2) insert tha new imageObject into imageObjects, (2) insert the new cell into the collection view
        // but first we need to resize the image cell so the photos we bring in arent too large and take up space.
        // heres the size for resizing our image
        let size = UIScreen.main.bounds.size
        
        // we will maintain the aspect ratio of the image here
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        // resize the image
        let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        
        // jpegData(compressionQuality: 1.0) converts to UIImage to Data
        // this makes sure we have a constant size for images
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        print("resized image size is \(resizeImage.size)")
        // create an image object using the image selected
        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        
        // insert the new image into our image our imageObjects array
        imageObjects.insert(imageObject, at: 0) // we always place images at the top
        
        // create an IndexPath for insertion into the collection view
        let indexPath = IndexPath(row: 0, section: 0)
        
        // insert our new cell into the collection view
        collectionView.insertItems(at: [indexPath])
        
        // persist imageObject into collectionView
        do {
            try dataPersistence.create(photo: imageObject)
        } catch {
            print("saving error: \(error)")
        }
    }
    
    // This is our toolbar button in which we will use to bring up the photos library or camera
    @IBAction func addPictureButtonPressed(_ sender: UIBarButtonItem) {
        // present an action sheet to the user
        // this is a subview on the bottom that allows for some options as they go through the app.
        
        // create our alert controller instance
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // every action corresponds to each button in the alert controller
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] alertAction in
            
            // We preset the .camera subview if the user chooses it
            self?.showImageController(isCameraSelected: true)
        }
        
        // using trailing closure syntax, we will write a completion handler with an argument "alertAction"
        // when the user clicks on photoLibraryAction, we will use a capture list to break any retain cycles because we are calling showImageController
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] alertAction in
            self?.showImageController(isCameraSelected: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // check if the camera is available, if the camera is not available we default to photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // this function figures out if the user selected the camera or photo library
    private func showImageController(isCameraSelected: Bool) {
        // the default source type will be .photolibrary
        imagePickerController.sourceType = .photoLibrary
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
}

// MARK: - UICollectionViewDatasource
extension ImagesViewController: UICollectionViewDataSource {
    
    // how many cells?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageObjects.count
    }
    
    // what is inside the cell?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // our cell must have an instance of object B to use our custom delegation
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? ImageCell else {
            fatalError("could not downcast to an ImageCell")
        }
        let imageObject = imageObjects[indexPath.row]
        cell.configureCell(imageObject: imageObject)
        
        // set the deleate object here to use our custom delegation
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

// MARK: - ImagePickerControllerDelegate & UINavigationControllerDelegate
extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // asks what the image is
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // we need to access the UIImagePickerController.InfoKey.originalImage key to get the UIImage that was selected.
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selected not found")
            return
        }
        
        selectedImage = image
        dismiss(animated: true)
    }
}

// MARK: -  ImageCellDelegate (our custom protocol for longPress)
extension ImagesViewController: ImageCellDelegate {
    func didLongPress(_ imageCell: ImageCell) {
        
        // grab out index path
        guard let indexPath = collectionView.indexPath(for: imageCell) else {
            return
        }
        
        // present our action sheet
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deleteImageObject(indexPath: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func deleteImageObject(indexPath: IndexPath) {
        dataPersistence.sync(photos: imageObjects)
        do {
            imageObjects = try dataPersistence.loadItems()
        } catch {
            print("loading error: \(error)")
        }
        
        // delete imageObject from imageObjects
        imageObjects.remove(at: indexPath.row)
        
        // delete cell from collection view
        collectionView.deleteItems(at:  [indexPath])
        
        do {
            // delete image object from documents directory
            try dataPersistence.delete(item: indexPath.row)
        } catch {
            print("error deleting item: \(error)")
        }
    }
}

// MARK: - UIImage extension
extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
