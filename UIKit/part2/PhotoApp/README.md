# Steps in project
<ol>
    <li>Setup ImageObject model</li>
    <li>Setup DataPersistence + FileManager</li>
    <li>Setup UI</li>
    <li>Setup ImageCell</li>
    <li>Setup ImagesViewController</li>
</ol>

# ImageObject
This is our data model for the images we will save. It primarily includes (1) imageData: Data, (2) date: Date

# Data Persistence + FileManager
This is how we will date data into a PropertyList. This will allow the user to upload data to the plist to have data persist. The main function we use are

```swift
// encodes our image and writes data to the plist
private func save() throws {}

// used for reordering
private func sync(photos: [ImageObject]) {}

// takes an input (ImageObject), appends it to our ImageObject array and then hits save()
public func create(photo: ImageObject) throws {}

// this function loads items from the documents directory by first checking if the plist file exists, then decoding the data from the plist
public func loadItems() throws -> [ImageObject] {}

// this function deletes photos from the documents directory
// we first remove the an element from out ImageObject array, then hit save()
public func delete(item index: Int) throws {}
```

# ImageCell - Custom Delegation for longPress



```swift
// We define a protocol as such
protocol ImageCellDelegate: AnyObject {
    func didLongPress(_ imageCell: ImageCell)
}

// Here we also bring in an imageView for our CollectionViewCell

// This property will create an instance of UILongPressGestureRecognizer()
// We use that instance to add a target with an action with a selector to longPressAction(gesture:)
private lazy var longPressGesure: UILongPressGestureRecognizer = {}()

// This is an objc function which will use our delegate object from out protocol to notify of any updates
// We will notify the ImgeViewController when the user long presses on the cell
@objc
private func longPressAction(gesture: UILongPressGestureRecognizer) {}

public func configureCell(imageObject: ImageObject) {}
```

# ImageViewController

```swift
// Heres the properties/outlet used in this file
@IBOutlet weak var collectionView: UICollectionView!
private var imageObjects = [ImageObject]()
private let imagePickerController = UIImagePickerController(). // used for our action sheet
private let dataPersistence = Persistence(filename: "photos.plist")

private var selectedImage: UIImage? {
    didSet {
        appendNewPhotoToCollection()
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    imagePickerController.delegate = self
    loadImageObjects()
}

// This functions loads photos from the PropertyList via our Persistence file
private func loadImageObjects() {}

// We bring in our selectedImage and resize it
// With the resized image we insert it into our ImageObject array
// Thne we create an IndexPath to insert a new cell in our collection view
// finally we persist the data using create()
private func appendNewPhotoToCollection() {}

// This is our toolbar button in which we will use to bring upp the photos library or camera
// When the user presses this we implement an action sheet with some options for the user
@IBAction func addPictureButtonPressed(_ sender: UIBarButtonItem) {}

// this function figures out if the user selected the camera or photo library
private func showImageController(isCameraSelected: Bool) {}

extension ImagesViwController: UICollectionViewDataSource {
    // we need to implement: numberOfItemsInSection(how many cells?) and cellForItemAt (whats inside the cell?)
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout { 
    // implements sizeForItemAt
}

extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // implements imagePickerControllerDidCancel
    // and didFinishPickingMediaWith (asks what the image is)
}

extension ImagesViewController: ImageCellDelegate {
    // implements ur custom delegation: didLongPress which also implements an action sheet
    // and deleteImageObject(indexPath: IndexPath {} -> this helps us delete a photo when the user long pressed the option
}

// we add in a function called "resizeImage" which takes in a width and a height and returns a UIImage
extension UIImage {}
```



# Photos App
<img src="https://media.giphy.com/media/TEf2d68zECL82giUuM/giphy.gif" width=250><br>

# Protocols
A protocol is an interface for some functionality. It can be adopted by a class, structure, enum in which we can define requirements by the protocol (functions, properties, etc). A protocol specifies types and wether each property is gettable/settable. If a protocol requires a property to be gettable or settable, that property requirement cant be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property. 

```swift

// this protocol we just made has a single instance property requirement
protocol FullyNamed {
    var fullName: String { get }
}

// this struct adopts and conforms to the FullyNamed protocol
struct Person: FullyNamed {
    var fullName: String
}

// each instance of person has a single stored property called fullName, 
// which is of type String. We have satisified the single requirement of the protocol.
let john = Person(fullName: "John Appleseed")



// this class implements the fulllName property requirement as a computed read-only 
// property for a starship. Each starship class instance stores a mandatory name and an optional prefix.  
class Starship: FullyNmed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterrprise", prefix: "USS"
```

Heres another example.

```swift
protocol Age {
    var age: Int { get }
}

struct Person: FullyNamed, Age {

    // this satiafies the protocol
    var fullName: String
    var age: Int
}

let chakane = Person(fullName:  "Chakane", age: 100)

```

### Method Requirements
Protocols can require instance methods and type methods to be implemented by conforming types. These methods are written as part of the protocol's definition in exactly the same way as for normal instance and type methods. With type property requirements, we always prefix type method requirements with the static keyword when theyre defined in the protocol. 

### Protocol Oriented Programming
Swift is a protocol oriented language; meaning that when we think about the architecture of the app, its best to think about how creating protocols can make you use reuseable, testable, and expandable code. 

### Delegation
This is a design pattern that enables a class or structure to hand-off or delegate some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (a delegate) is guaranteed to provide the functionality has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the type of that source. 

```swift

// heres a protocl we just made up
protocol SettingsDelegate: AnyObject {
    func darkModeOn()
    func darkModeOff()
    func setLabel(message: String)
}


class ViewController: UIViewController {
    @IBOutlet var myLabel: UILabel!
    var darkModeIsOn = false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.delegate = self
        }
    }
}

// conform to our protocol
extension ViewController: SettingsDelegate {
    func setLabel(message: String) {
        myLabel.text = message
    }
    
    func darkModeOff() {
        myLabel.textColor = .black
        self.view.backgroundColor = .white
        darkModeIsOn = false
    }
    
    func darkModeOn() {
        myLabel.textColor = .white
        self.view.background = .black
        darkModeIsOn = true
    }
}
```

```swift

// Add a delegate to a class that wants to update something else
class SettingsViewController: UIViewController {
    weak var delegate: SettingsDelegate?
    enum DarkModeSettings: String {
        case on, off
    }
    
    func setDarkMode(to setting: DarkModeSettings) {
        delegate?.setLabel(message: "Dark mode is \(setting.rawVale)")
        
        switch setting {
            case .on: delegate?.darkModeOn()
            case .off: delegate?.darkModeOff()
        }
    }
}
 
```
