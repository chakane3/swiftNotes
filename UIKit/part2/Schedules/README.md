# Persisting data

In this app we create a tool to help schedule events in the future. We will also be able to mark completed events in a seperate view. Here is what the UI may look like. (insert UI)

## FileManager

This is a class that lets you examine the contents of the file system and make changes to it. We use it to lcate, create, copy, and move files and directories. In our app we need the users directory to the documents folder; therefore we need to extend FileManager to create a function for our purpose. 
<details>
  <summary>FileManager Extension</summary>

```swift
import Foundation

extension FileManager {
    // know the difference between a type and an instance method
    // let fileManager = FileManager()
    // fileManager.etDocumentsDirectory() <- instance
    
    // FileManager.getDocumentsDirectory <- type method
    
    // this function grabs the users path to the documents directory
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // this function appends the users documents directory to the rest of the path needed
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
```
</details>

## The Model
In this app the event will only need an object with only 2 properties: (1) date: Date, (2) name: String
```swift
import Foundation

struct Event: Codable {
    var date: Date
    var name: String
}
```

## Setup Persistence
 Recall, we need to create a file to store user setting  called "yourFile.plist". Here is where we have our function to perfrom CRUD operations on our .plist file
 
<details>
  <summary>Persistence Setup</summary>
  
```swift
import Foundation

enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class Persistence {
    
    // array of events
    private static var events = [Event]()
    
    // setup the name of the file
    private static let filename = "schedules.plist"
    
    
    // this function wrties data to the plist file.
    private static func save() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // the events array will be the object being converted to a Data array
        // we'll write the Data object to the documents directory
        do {
            // convert the events array to Data
            let data =  try PropertyListEncoder().encode(events)
            
            // writes the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // reordering
    public static func reorderEvents(events: [Event]) {
        self.events = events
        try? save()
    }
    
    // save item to documents directory
    // this function help create a new entry in our file
    static func create(event: Event) throws {
        // append the new event to the events array
        events.append(event)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // load items from documents directory
    static func loadEvents() throws -> [Event] {
        // we need access to the filename URL that were reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if the file exists
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
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
    
    // remove item from documents directory
    static func delete(event index: Int) throws {
        // remove item from the evens array
        events.remove(at: index)
        
        // save our events array to the documents directory
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}

```
</details>

## Create Event
When the user creates an event we use an IBAction on the date picker to capture the date, and then resignFirstResponser() on the textField to capture our event name. This may look like:

```swift
import UIKit

class CreateEventController: UIViewController {
    @IBOutlet weak var createEventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // the property we'll use to send back to ScheduleListController
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createEventTextField.delegate = self
        event = Event(date: Date(), name: "Swift rocks")
    }
    
    
    // captures users date
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        // update the date of the event
        event?.date = sender.date
    }
}

// captures the name of the event
extension CreateEventController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        event?.name = textField.text ?? "no event name"
        return true
    }
}
```

## Schedule List Controller
Here, we first begin by bringing in our Events array up top after connecting our tableView. Another property we will have is "isEditingTableView" which is a Bool that dictates when a row is being edited or not. We also use a property observer on our dateFormatter variable.<br></br>

In our VDL we need to load our events for our View Controller (this is ran inside the VDL). We then have a deleteEvent(indexPath: IndexPath) function to delete a row when the user wants it gone. We have an IBAction which takes passed value (Event()) from CreatEventController; when this happens we write it to the users document, append the array to our events variable, create an index path for it, and then insert it in our table view.<br></br>

Lastly we have an IBAction for when the edit button is pressed to toggle our isEditngTableView property. We then will have an extensive use of UITableViewDataSource which is better looked at in code. 
<details>
  <summary>ScheduleListController setup</summary>
  
```swift
class ScheduleListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // data - an array of events
    var events = [Event]()
    
    var isEditingTableView = false {
        didSet { // property observer
            // toggle editing mode of table view
            tableView.isEditing = isEditingTableView
            
            // toggle bar button item's title between "Edit" and "Done"
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    lazy var dateFormatter:  DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy, hh:mm a"
        formatter.timeZone = .current
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
        tableView.dataSource = self
        
        // print path to documents directory
        //    print(FileManager.getDocumentsDirectory())
    }
    
    // run this in VDL
    private func loadEvents() {
        do {
            events = try Persistence.loadEvents()
        } catch {
            print("error loading events: \(error)")
        }
    }
    
    private func deleteEvent(indexPath: IndexPath) {
        do {
            try Persistence.delete(event: indexPath.row)
        } catch {
            print("error deleting event: \(error)")
        }
    }
    
    @IBAction func addNewEvent(segue: UIStoryboardSegue) {
        // caveman debugging
        
        // get a reference to the CreateEventController instance
        guard let createEventController = segue.source as? CreateEventController,
              let createdEvent = createEventController.event else {
                  fatalError("failed to access CreateEventController")
              }
        
        // persist (save) event to documents directory
        do {
            try Persistence.create(event: createdEvent) // adds event at the of array
        } catch {
            print("error saving event with error: \(error)")
        }
        
        // insert new event into our events array
        events.append(createdEvent)
        
        // create an indexPath to be inserted into the table view
        let indexPath = IndexPath(row: events.count - 1, section: 0) // will represent top of table view
        
        // 2. we need to update the table view
        // use indexPath to insert into table view
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle() // changes a boolean value
    }
}

extension ScheduleListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = dateFormatter.string(from: event.date)
        return cell
    }
    
    // MARK:- deleting rows in a table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            // only gets called if "insertion control" exist and gets selected
            print("inserting....")
        case .delete:
            print("deleting..")
            // 1. remove item for the data model e.g events
            events.remove(at: indexPath.row) // remove event from events array
            
            deleteEvent(indexPath: indexPath)
            
            // 2. update the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("......")
        }
    }
    
    // MARK:- reordering rows in a table view
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let eventToMove = events[sourceIndexPath.row] // save the event being moved
        events.remove(at: sourceIndexPath.row)
        events.insert(eventToMove, at: destinationIndexPath.row)
        
        // re-save array in docuemnts directory
        Persistence.reorderEvents(events: events)
        do {
            events = try Persistence.loadEvents()
            tableView.reloadData()
        } catch {
            print("error loading events: \(error)")
        }
    }
}
```
</details>
