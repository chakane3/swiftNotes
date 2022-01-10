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














