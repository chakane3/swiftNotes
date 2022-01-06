//
//  Persistence.swift
//  Horoscope
//
//  Created by Chakane Shegog on 1/6/22.
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
    
    // The user
    private static var user: Person?
    
    // name of file
    private static let filename = "user.plist"
    
    // this function writes data to the plist file
    private static func save() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // the person property will be the object that will be converted in a Data object
        // We'll write the object to the documents directory
        do {
            // convert the Person to Data
            let data = try PropertyListEncoder().encode(user)
            
            // write the data to user.plist
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // load the data from the documents directory
    static func loadEvents() throws -> Person {
        // access the filename URL that we're reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if the file exists
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    user = try PropertyListDecoder().decode(Person.self, from: data)
                } catch {
                    throw DataPersistenceError.fileDoesNotExist(filename)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return user  ?? Person(name: "OOOOOO", birthday: Date())
    }
}
