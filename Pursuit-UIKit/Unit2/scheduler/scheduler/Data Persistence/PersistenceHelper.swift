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
    
    
}

