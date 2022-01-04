//
//  ScheduleListController.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//

import UIKit

class ScheduleListController: UIViewController {
    weak var tableView: UITableView!
    
    // array of events
    var events = [Event]()
    
    var isEditingTableView = false {
        didSet {
            // toggle editing mode of the table view
            tableView.isEditing = isEditingTableView
            
            // toggle bar button item;s title between edit and done
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM, yyyy, hh:mm a"
        formatter.timeZone = .current
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
        tableView.dataSource = self
    }
    
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
        
        // get reference to the CreateEventController instance
        guard let createEventController = segue.source as? CreateEventController, let createdEvent = createEventController.event else {
            fatalError("failed to access CreateEventController")
        }
        
        // persist event to documents directory
        do {
            try Persistence.create(event: createdEvent)
        } catch {
            print("error saving event: \(error)")
        }
        
        // insert a new array into our events array
        events.append(createdEvent)
        
        // create an index path to be inserted into the table view
        let indexPath = IndexPath(row: events.count - 1, section: 0) // represents the top of the table view
        
        // we need to update the table view by using the indexPath to insert the event into the table view
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            // this only gets called if "insertion control" exists and gets selected
            print("inserting...")
        case .delete:
            print("deleting...")
            
            // remove the item from the data model
            events.remove(at: indexPath.row)
            deleteEvent(indexPath: indexPath)
            
            // update the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("...")
        }
    }
    
    // function for reordering
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let eventToMove = events[sourceIndexPath.row] // save the event being moved
        events.remove(at: sourceIndexPath.row)
        events.insert(eventToMove, at: destinationIndexPath.row)
        
        // re-save array in documents directory
        Persistence.reorderEvnets(events: events)
        do {
            events = try Persistence.loadEvents()
            tableView.reloadData()
        } catch {
            print("error loading events: \(error)")
        }
    }
}
