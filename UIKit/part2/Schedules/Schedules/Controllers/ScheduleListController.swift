//
//  ScheduleListController.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//
import UIKit

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
        tableView.delegate = self
        
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
    
    @IBAction func newEventWillBeAdded(segue: UIStoryboardSegue) {
        // caveman debugging
        
        // get a reference to the CreateEventController instance
        guard let createEventController = segue.source as? CreateEventController, let newEvent = createEventController.event, !newEvent.name.isEmpty else {
            print("could not create new event")
            return
        }
        
        if createEventController.eventState == .existingEvent {
            let index = events.firstIndex { $0.identifier == newEvent.identifier }
            guard let itemIndex = index else { return }
            let oldEvent = events[itemIndex]
            update(oldEvent: oldEvent, with: newEvent)
            
        } else {
            createNewEvent(event: newEvent)
        }
        
        
        
        // MARK: - Old Method
//        // persist (save) event to documents directory
//        do {
//            try Persistence.create(event: newEvent) // adds event at the of array
//        } catch {
//            print("error saving event with error: \(error)")
//        }
//
//        // insert new event into our events array
//        events.append(newEvent)
//
//        // create an indexPath to be inserted into the table view
//        let indexPath = IndexPath(row: events.count - 1, section: 0) // will represent top of table view
//
//        // 2. we need to update the table view
//        // use indexPath to insert into table view
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func update(oldEvent: Event, with newEvent: Event) {
        // update item in documents directory
        // call load itmes to update events array
    }
    
    private func createNewEvent(event: Event) {
        
    }
    
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle() // changes a boolean value
    }
    
    
    // presents the creatEventController when the user clicks on this button
    @IBAction func createEventButtonPressed(_ sender: UIBarButtonItem) {
        showCreateEventVC()
    }
    
    private func showCreateEventVC(_ event: Event? = nil) {
        // use the storyboard to get an instance of the CreatEventController
        guard let createEventController = storyboard?.instantiateViewController(withIdentifier: "CreateEventController") as? CreateEventController else {
            fatalError("Could not downcase to CreateEventController")
        }
        createEventController.event = event
        present(createEventController, animated: true)
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

extension ScheduleListController: UITableViewDelegate {
    
    // this function gets called when a user selects a tableview cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        showCreateEventVC(event)
    }
}
