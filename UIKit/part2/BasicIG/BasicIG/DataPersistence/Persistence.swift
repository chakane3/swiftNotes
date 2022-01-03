//
//  Persistence.swift
//  BasicIG
//
//  Created by Chakane Shegog on 1/2/22.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    private var items = [ImageObject]()
    private var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private func save() throws {
        // get the url path to the file that the event will be saved to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // our items array will be converted to Data
        // we'll use the data object and write it to the documents directory
        do {
            // convert the items array to data
            let data = try PropertyListEncoder().encode(items)
            
            // write the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // reordering
    public func sync(items: [ImageObject]) {
        self.items = items
        try? save()
    }
    
    // save an item to the documents directory
    public func create(item: ImageObject) throws {
        // append the new item to the items array
        items.append(item)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // load (retrieve) items from documents directory
    public func loadItems() throws -> [ImageObject] {
        
        // we need access to the filename URL that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if the file exists
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    items = try PropertyListDecoder().decode([ImageObject].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return items
    }
    
    // remove items from the documents directory
    public func delete(item index: Int)  throws {
        
        // remove the item from the events array
        items.remove(at: index)
        
        // save our events array to the documents directory
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
