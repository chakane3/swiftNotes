# Save and persist completed events 

<app gif>

## Persistence
For this app we need to save the events we made in a PropertyList. The user will be able to create an event that persists and have the option to "complete" the event which shows up in another view (this is also persisted). The first thing we need to accomplish is extending our FileManager to grab the apps documents directory and get the path for it so we can write or read data into our plist file. 

## Event Model
The data for each event will look like this

```swift
import Foundation

struct Event: Codable & Equatable {
    let identifier = UUID().uuidString
    var date: Date
    var name: String
}
```

<details>
<summary>file manager extension</summary>

```swift
import Foundation

public enum Directory {
    case documentsDirectory
    case cachesDirectory
}

extension FileManager {

    // this function returns the path to the documents directory
    public static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentsDirectory, in: .userDomainMask)[0]
    }
    
    // this function returns the path to the caches directory
    public static func getCachesDirectory() -> URL {
        return FileManager.default.urls(for: .documentsDirectory, in: .userDomainMask)[0]
    }
    
    // this function takes a filename as a parameter, then appends it to the documents directory's path name
    // it then returns that path in which it will be used to read or wrtie data
    public static func getPath(with filename: String, for directory: Directory) -> URL {    
        switch directory {
            case .cachesDirectory:
                return getCachesDirectory().appendingPathComponent(filename)
            case .documentsDirectory:
                return getDocumentsDirectory().appendingPathComponent(filename)
        }
    }
}
```
</details>



Now we can begin writing our class to help us persist items within the app. Heres a possible list of errors to help us debug.


```swift
import Foundation

// possible errors when persisting or loading data from our plist file
public enum DataPersistenceError: Error {
    case propertyListEncodingError(Error)
    case propertyListDecodingError(Error)
    case writingError(Error)
    case deletingError
    case noContentsAtPath
}
```

For this class we want to create a custom delegation for deleting an itme. We want to notify this class that the user is deleting something and therefore needs to delete the item from the plist file. Recall, that delegation is a design pattern which enables a class or struct to delegate s responsibility to an instance of another type. We implement this design by defining a protocol that encapsulates the delegated responsibilities. Delegation can be used to respond to a specific action, or to get data from an external source without needing to know the type of that source. 

<details>
<summary>Persistence file</summary>

```swift
import Foundation

// defines a protocol
protocol DataPersistenceDelegate: AnyObject {
    // this function checks if we deleted an item*
    func didDeleteItem<T>(_ persistenceHelper: Persistence<T>, item: T)
}

// here we create a new type
typealias Writeable = Codable & Equatable

// we constrain our Persistence class to only work with Codable types
class Persistence<T: Writeable> {
    private let filename: String
    private var items: [T]
    
    // this reference property will be registered at the object listening for notification
    // we use "weak" to break a strong reference cycle between the delegate object and the Persistence class
    weak var delegate: DataPersistenceDelegate?
    
    // we need a filename to create an instance of this class
    public init(filename: String) {
        self.filename = filename
        self.items = []
    }
    
    // allows us to encode(write) data to our plist
    private func saveItemsToDocumentsDirectory() throws {
        do {
            let url = FileManager.getPath(with: filename, for: .documentsDirectory)
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.writingError(error)
        }
    }
    
    // create an item
    public func createItem(_ item: T) throws {
        _ = try? loadItems() // checks if our file exists, then loads items
        items.append(item) // throw our new event in our items array
        do {
        
            // write our item in the plist file
            try saveItemsToDocumentsDirectory()
        } catch {
            throw DataPersistenceError.writingError(error)
        }
    }
    
    // read
    public func loadItems() throws -> [T] {
    
        // check if our file exists
        let path = FileManager.getPath(with: filename, for: .documentsDirectory).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
            
                // if the file exists, decode whatever is in the plist
                items = try PropertyListDecoder().decode([T].self, from: data)
                } catch {
                    throw DataPersistenceError.propertyListDecodingError(error)
                }
            } 
        }
        return items
    }
    
    // update - replaces the old with the new
    @discardableResult
    public func update(_ oldItem: T, with newItem: T) -> Bool {
        if let index = items.firstIndex(of: oldItem) {
            let result = update(newItem, at: index)
            return result
        }
        return false
    }
    
    @discardableResult
    public func update(_ item: T, at index: Int) -> Bool {
        items[index] = item
        do {
            try saveItemsToDocumentsDirectory()
            return true
        } catch {
            return false
        }
    }
    
    // delete
    public func deleteItem(at index: Int) throws {
        // remove item from our array via index then try to save our documents directory
        let deletedItem = items.remove(at: index)
        do {
            try saveItemsToDocumentsDirectory()
            
            // here we use our delegate reference to notify the observer of deletion
            delegate?.didDeleteItem(self, item: deletedItem)
        } catch {
            throw DataPersistenceError.deletingError
        }
    }
    
    // used for re-ordering
    public func synchronize(_ items: [T]) {
        self.items = items
        try? saveItemsToDocumentsDirectory()
    }
    
    // checks if our item has been saved
    public func hasItemBeenSaved(_ item: T) -> Bool {
    
        // check if we can load our items
        guard let items = try? loadItems() else {
            return false
        }
        
        // and new item is always at the top of the list (.firstIndex)
        self.items = items
        if let _ = self.items.firstIndex(of: item) {
            return true
        }
        return false
    }
    
    // remove all items from plist
    public func removeAll() {
        guard let loadedItems = try? loadedItems() else {
            return
        }
        items = loadedItems
        items.removeAll()
        try? saveItemsToDocumentsDirectory()
    }
}

```

</details>

# Create an event
We need to generate data for this app. Therefore we will setup a view in which the user can create an event. Everytime the user creates an event we persist it to our plist file

<details>
<summary>CreateEvent File</summary>

```swift
import UIKit

// we use this enum to switch states between the user creating a new event and the user updating an event
enum EventState {
    case newEvent
    case existingEvent
}

class CreateEvent: UIViewController {
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var event: Event?
    
    // public private allows a "read-only" version of this property
    prublic private(set) var eventState = EventState.newEvent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    private func updateUI() {
        if let event = event {
            self.event = event
            datePicker.date = event.date
            eventNameTextField.text = event.name
            eventButton.setTitle("Update event", for: .normal)
            eventState = .existingEvent
        } else {
            // instantiate a default value for event
            event = Event(date: Date(), name: "")
            eventState = .newEvent
        }
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        // update the name of the event
        event?.date = sender.date
    }
}

// conform to UITextFieldDelegate
extension CreateEvent: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        
        // update the name of the event
        event?.name = textField.text ?? "no event name"
        return true
    }
}
```

</details>

## Schedule List view
This view shows us the events the user has created. 

<details>
<summary>ScheduleList file</summary>

```swift
import UIKit

class ScheduleList: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var events = [Event]()
    
    // property to access our Persistence class
    public var dataPersistence: Persistence<Event>!
    
    private var isEditingTableView = false {
        didSet {
            tableView.isEditing = isEditingTableView
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
    }
    
    // try to load items from our plist
    private func loadItems() {
        do {
            events = try dataPersistence.loadItems()
            tableView.reloadData()
        } catch {
            print("loading items error: \(error)")
        }
    }
    
    // this is our + button
    @IBAction func newEventWillBeAdded(segue: UIStoryboardSegue) {
        // get a reference to the CreateEvent instance
        guard let createEvent = segue.source as? CreateEvent, 
            let newEvent = createEvent.event, 
            !newEvent.name.isEmpty else {
                print("could not create a new event")
                return
        }
        
        // if were updating an event
        if createEvent.eventState == .existingEvent {
            let index = events.firstIndex {$0.identifier == newEvent.identifier}
            guard let itemIndex = index else { return }
            let oldEvent = events[itemIndex]
            update(oldEvent: oldEvent, with: newEvent)
        } else {
        
            // if were making a whole new event
            createNewEvent(event: newEvent)
        }
    }
    
    private func update(oldEvent: Event, with newEvent: Event) {
        // update the item in the documents directory
        dataPersistence.update(oldEvent, with: newEvent)
        loadItems()
    }
    
    private func createNewEvent(event: Event) {
        // insert the new event into our events array
        // update the data model
        events.append(event)
        
        let indexPath = IndexPath(row: events.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        try? dataPersistence.createItem(event)
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle()
    }
    
    @IBAction func createEventButtonPressed(_ sender: UIBarButtonItem) {
        showCreateEventVC()
    }
    
    // this function allows us to present our CreateEvent view that we made on the storyboard
    // nil is used as a default parameter
    private func showCreateEventVC(_ event: Event? = nil) {
        // we need to use the storyboard to get an instance of the createEvent view
        guard let createEvent = storyboard?.instantiateViewController(identifier: "CreateEventController") as? CreateEvent else {
            fatalError("could not downcast to CreateEventController")
        }
        
        // for updating an event, we will "inject" (dependency injection) the selected event
        // if something "depends" on something, you iject it by instantiating a property
        createEvent.event = event
        present(createEvent, animated: true)
    }
}

extension ScheduleList: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReuseableCell(withIdentifier: "eventCell", for: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.date.formatted()
        return cell
    }
    
    // this function helps us delete rows in a table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .insert:
                // this only gets called if "insertion control" exists and gets selected
                print("inserting...")
                
            case .delete:
                // remove the item from each data model
                events.remove(at: indexPath.row)
                
                // remove our item from the documents directory
                try? dataPersistence.deleteItem(at: indexPath.row)
                
                // update tableview
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                print("deleting...")
                
            default:
                print("...")
        }
    }
    
    // reorder rows in a table view
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let eventToMove = events[sourceIndexPath.row] // save the event being moved
        events.remove(at: sourceIndexPath.row)
        events.insert(eventToMove, at: destinationIndexPath.row)
        
        // re-save array in documents directory
        dataPersistence.synchronize(events)
        loadItems()
    }
}

extension ScheduleList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        showCreateEventVC(event)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Completed events"
    }
}
```

</details>

## Delegate between tabs

<details>
<summary>SchedulesTab file</summary>

```swift
import UIKit

class SchedulesTab: UITabBarController {
    private let dataPersistence = Persistence<Event>(filename: "schedules.plist")
    
    // we need instances of the 2 tabs in our storyboard
    private lazy var schedulesNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "SchedulesNavController") as? UINavigationController, 
            let schedulesList = navController.viewControllers.first as? ScheduleList else {
            fatalError("could not load nav controller")
        }
        
        // set the data persistence property
        schedulesList.dataPersistence = dataPersistence
        return navController
    }()
    
    // we need access to the UINavigationController
    // then we access the first view controller
    private lazy var completedNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "CompletedNavController") as? UINavigationController, 
            let completedController = navController.viewControllers.first as? CompletedSchedule else {
                fatalError("could not load nav controller")
        }
        
        // set dataPersistence property
        completedController.dataPersistence = dataPersistence
        
        // set our delegate object
        completedController.dataPersistence.delegate = completedController
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [schedulesNavController, completedNavController]
    }
}
```

</details>





