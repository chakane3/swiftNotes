//
//  CompletedSchedule.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/17/22.
//

import UIKit

class CompletedSchedule: UIViewController {
    
    // MARK: - Properties and outlets
    
    private var completedEvents = [Event]() {
        didSet {
            guard let tableView = tableView else { return }
            tableView.reloadData()
        }
    }
    
    private let completedEventsPersistence = Persistence<Event>(filename: "completedEvents.plist")
    public var dataPersistence: Persistence<Event>!
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Applife cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadCompletedItems()

    }
    
    
    // MARK: - Functions and actions
    private func loadCompletedItems() {
        do {
            completedEvents = try completedEventsPersistence.loadItems()
        } catch {
            print("error loading completed events: \(error)")
        }
    }
}

// MARK: - UITableViewDataSource
extension CompletedSchedule: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let event = completedEvents[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.date.formatted()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            completedEvents.remove(at: indexPath.row)
            
            // persist our change
            do {
                try completedEventsPersistence.deleteItem(at: indexPath.row)
            } catch {
                print("error deleted completed task: \(error)")
            }
        }
    }
}

// MARK: - Custom delegation
extension CompletedSchedule: DataPersistenceDelegate {
    func didDeleteItem<T>(_ persistenceHelper: Persistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        // persist our item to the completed events persistence
        do {
            let event = item as! Event
            try completedEventsPersistence.createItem(event)
        } catch {
            print("error creating item: \(error)")
        }
        
        // reload completed item array
        loadCompletedItems()
    }
}
