//
//  Persistence.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//

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
    private static let filename = "schedules.plist"
    
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
    public static func reorderEvnets(events: [Event]) {
        self.events = events
        try? save()
    }
    
    // save item to documents directory
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
