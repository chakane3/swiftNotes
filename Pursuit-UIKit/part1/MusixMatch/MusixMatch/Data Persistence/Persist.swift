//
//  Persist.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 1/1/22.
//

import Foundation

// these set of enums of potential errors when saving data
enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class Persistence {
    // we'll have an array of either songs, artists, or albumbs
    
    // an array of tracks
    private static var savedTracks = [Tracks]()
    
    private static let filename = "savedTracks.plist"
    
    // save item to documents directory
    static func saveItem(track: Tracks) throws {
        savedTracks.append(track)
        try save()
    }
    
    // used when we create update or delete
    static func save() throws {
        
        // get the url path in which well save our file to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // tracks array will be the object being converted to data
        // we'll use the data object and write/save it to our documents
        do {
            // encode the tracks data to objects, then write it to our URL
            let data = try PropertyListEncoder().encode(savedTracks)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // get items from documents directory
    static func loadTracks() throws -> [Tracks] {
        
        // we need access to the filename url that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if the fle exists
        if FileManager.default.fileExists(atPath: url.path) {
            
            // read from file; check for persistence errors -> noData
            if let data = FileManager.default.contents(atPath: url.path) {
                
                // check if we get a decoding error
                do {
                    savedTracks = try  PropertyListDecoder().decode([Tracks].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return savedTracks
    }
    
}
