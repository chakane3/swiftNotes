//
//  PersistenceHelper.swift
//  scheduler
//
//  Created by Chakane Shegog on 12/7/21.
//

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

