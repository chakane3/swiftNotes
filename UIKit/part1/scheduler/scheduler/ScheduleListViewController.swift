//
//  ScheduleListViewController.swift
//  scheduler
//
//  Created by Chakane Shegog on 12/7/21.
//

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
