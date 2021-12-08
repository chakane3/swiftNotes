# Scheduler (data persistence)

We'll create an app to have a user create new events with a date and time and add it to our existing table view. We go over CRUD operations which modify our "schedules.plist". The .plist file is used to save data the user generated on the app. This is similar to settings on an app.

## #1 The UI
We use a<br>
<ul>
  <li>VC embedded in a nav controller</li>
  <li>table view in the VC</li>
  <li>Edit bbar button item</li>
  <li>The VC has a bar button item to a new VC</li>
  <li>date picker in a seperate VC</li>
  <li>text field in the seperate VC with a post button</li>
</ul>
<img src="/Pursuit-UIKit/Unit2/scheduler/Assets/schedulerUI.png"></img>

## #2 Event Model (what does an event look like?
Our event will have a name and a date

```swift

struct Event: Codable {
    var date: Date
    var name: String
}

```

## #3 Data Persistence

<details>
  <summary>Extend FileManager</summary>
  
  ```swift
  
import Foundation

// here we want to include a new function for FileManager
extension FileManager {
    // we can use the file manager to grab the directory of our users document.
    
    // note that removing static func this function will force us to make an
    // instance of let fileManager = FileManager(); static creates an instance for us.
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // this helper function appends a filename to the documents directory
    // i.e documents/yourFile.plist
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    } 
}
  
  ```
</details>

<details>
  <summary>Data persistence helper</summary>
  
  ```swift
import Foundation

// set up an enum for when our app runs into potential errors
enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    // array of events
    private static var events = [Event]()
    
    // create file name
    private static let filename = "schedules.plist"
    
    // save item - save item to documents directory
    static func saveItem(event: Event) throws {
        events.append(event) // append a new event to our events array
        try save()
    }
    
    // used when we create, update, delete
    static func save() throws {
        
        // get the url path, save it to the file it will be used in
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // events array will be the object being converted to data
        // we'll use the Data object and write/save it to our documents
        do {
            
            // encode the events data to objects, then write it to our url
            let data = try PropertyListEncoder().encode(events)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // load = retrieve items from documents directory
    static func loadEvents() throws -> [Event] {
        
        // we need access to the filename url that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if the file exists
        if FileManager.default.fileExists(atPath: url.path) {
            
            // read from the file; check for persistence errors -> noData
            if let data = FileManager.default.contents(atPath: url.path) {
                
                // check if we get a decoding error
                do {
                    events = try PropertyListDecoder().decode([Event].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return events
    }
    
    // delete - remove item from documents directory
    static func delete(event index: Int) throws {
        // remove the item
        events.remove(at: index)
        
        // save the updated events array to the documents directory
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
  ```
</details>

## #4 Creating an Event
We need to use our event model to fill in a date and name and then use it to add to our tableview
<details>
  <summary>CreateEventController</summary>
  
  ```swift
import UIKit

class createEventViewController: UIViewController {
    @IBOutlet weak var eventField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventField.delegate = self
        event = Event(name: "Swifty 4 life", date: Date())
    }

    // along with the IBOutlet we need and IBAction to update the event date
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        event?.date = sender.date
    }
}

// we need to conform to UITextField delegate to use it
extension createEventViewController: UITextFieldDelegate {
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

# The Main View, putting it all together
<details>
  <summary>ScheduleListVC</summary>
  
  ```swift
import UIKit

class ScheduleListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // an array of events
    var events = [Event]()
    
    // boolean used to check if user is editing tableView
    var isEditingTableView = false {
        didSet {
            // toggle editing mode of table view
            // then toggle the barbutton item's title between "Edit" and "Done"
            tableView.isEditing = isEditingTableView
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    // format date to a more user friendly way
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d yyyy, hh:mm a"
        formatter.timeZone = .current
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // load our array to our TV (load from plist)
    private func loadEvents() {
        do {
            events = try PersistenceHelper.loadEvents()
        } catch {
            print("error loading events: \(error)")
        }
    }
    
    // delete our event from our plist
    private func deleteEvent(indexPath: IndexPath) {
        do {
            try PersistenceHelper.delete(event: indexPath.row)
        } catch {
            print("Error in deleting: \(error)")
        }
    }
    
    @IBAction func addNewEvent(_ segue: UIStoryboardSegue) {
        
        // get a reference to the CreateEventCiewController instance
        guard let createEventViewController = segue.source as? createEventViewController, let createdEvent = createEventViewController.event else {
            fatalError("failed to access CreateEventViewController")
        }
        
        // persist (save) elements to the documents directory
        do {
            try PersistenceHelper.saveItem(event: createdEvent)
        } catch {
            print("Error: saving event with error -> \(error)")
        }
        
        // insert our new event ino our events array (at the top)
        events.insert(createdEvent, at: 0)
        
        // create an indexPath to be inserted into the tableView
        let indexPath = IndexPath(row: 0, section: 0)
        
        // use indexPath to insert an event to our table view
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    // change the boolean value is isEditingTableView
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle()
    }
}

extension ScheduleListViewController: UITableViewDataSource {
    
    // what should the cells looks like?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = dateFormatter.string(from: event.date)
        return cell
    }
    
    // how many elements?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    // here we only really focus on deleting something from a table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            
        case .insert:
            // gets called is "insertion control" exists and gets selected
            print("inserting ...")
            
        case .delete:
            // remove item for the data model
            deleteEvent(indexPath: indexPath)
            
            // update the tableview
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        default:
            print("...")
        }
    }
    
    
    // re-order the table view
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let eventToMove = events[sourceIndexPath.row]
        events.remove(at: sourceIndexPath.row)
        events.insert(eventToMove, at: destinationIndexPath.row)
    }
}
  
  ```
  
</details>


