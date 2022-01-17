//
//  ScheduleList.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/16/22.
//

import UIKit

class ScheduleList: UIViewController {
    
    // MARK: - Properties and outlets
    @IBOutlet weak var tableView: UITableView!
    
    // property to hold our array of events
    private var events = [Event]()
    
    public var dataPersistence: Persistence<Event>!
    
    
    private var isEditingTableView = false {
        didSet {
            tableView.isEditing = isEditingTableView
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    // MARK: - App Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
    }
    
    
    // MARK: - Functions and actions
    
    private func loadItems() {
        do {
            events = try dataPersistence.loadItems()
            tableView.reloadData()
        } catch {
            print("loading items error: \(error)")
        }
    }
    
    @IBAction func newEventWillBeAdded(segue: UIStoryboardSegue) {
        // get a reference to the CreateEvent instance
        guard let createEvent = segue.source as? CreateEvent, let newEvent = createEvent.event, !newEvent.name.isEmpty else {
            print("could not create new event")
            return
        }
        
        if createEvent.eventState == .existingEvent {
            let index = events.firstIndex {$0.identifier == newEvent.identifier}
            guard let itemIndex = index else { return }
            let oldEvent = events[itemIndex]
            update(oldEvent: oldEvent, with: newEvent)
        } else {
            createNewEvent(event: newEvent)
        }
    }
    
    private func update(oldEvent: Event, with newEvent: Event) {
        // update the item in documents directory
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
    
    
    // this function allows us to present out CreateEvent view that we made on storyboard
    // nil here is used as a default parameter
    private func showCreateEventVC(_ event: Event? = nil) {
        // we need to use the storyboard to get an instance of the createEvent view
        guard let createEvent = storyboard?.instantiateViewController(identifier: "CreateEventController") as? CreateEvent else {
            fatalError("could not downcast to CreateEventController")
        }
        
        // for updating an event we will "inject" (dependency injection) the selected event
        // if something "depends" on something you inject it by initialiing a property
        createEvent.event = event
        present(createEvent, animated: true)
    }
}


// MARK: - UITableViewDataSource

extension ScheduleList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
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
            print("deleting..")
            // remove the item from the data model
            events.remove(at: indexPath.row)
            
            // remove our item from the documents directory
            try? dataPersistence.deleteItem(at: indexPath.row)
            
            // update the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
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

// MARK: - UITableViewDelegate
extension ScheduleList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        showCreateEventVC(event)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Completed events"
    }
}
