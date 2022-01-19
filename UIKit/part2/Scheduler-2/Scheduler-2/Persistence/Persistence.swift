//
//  Persistence.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/16/22.
//

import Foundation

public enum DataPersistenceError: Error {
    case propertyListEncodingError(Error)
    case propertyListDecodingError(Error)
    case writingError(Error)
    case deletingError
    case noContentsAtPath(String)
}

// here we define a protocol (custom delegation setup)
protocol DataPersistenceDelegate: AnyObject {
    func didDeleteItem<T>(_ persistenceHelper: Persistence<T>, item: T)
}


typealias Writeable = Codable & Equatable


// we constrain Persistence to now only work with Codable types
// T is a generic
class Persistence<T: Writeable> {
    private let filename: String
    private var items: [T]
    
    // define a reference property that will be registered at the object listening for notifications
    // we use "weak" to break a strong reference cycle between the delegate object and the Persistence class
    weak var delegate: DataPersistenceDelegate?
    
    
    // we need a filename to create an instance of this class
    public init(filename: String) {
        self.filename = filename
        self.items = []
    }
    
    private func saveItemsToDocumentsDirectory() throws {
        do {
            let url = FileManager.getPath(with: filename, for: .documentsDirectory)
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.writingError(error)
        }
    }
    
    // CRUD operations
    
    // create
    public func createItem(_ item: T) throws {
        _ = try? loadItems()
        items.append(item)
        do {
            try saveItemsToDocumentsDirectory()
        } catch {
            throw DataPersistenceError.writingError(error)
        }
    }
    
    // read
    public func loadItems() throws -> [T] {
        let path = FileManager.getPath(with: filename, for: .documentsDirectory).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([T].self, from: data)
                } catch {
                    throw DataPersistenceError.propertyListDecodingError((error))
                }
            }
        }
        return items
    }
    
    // update
    @discardableResult // silences a warning if the return value is not used by the caller
    public func update(_ oldItem: T, with newItem: T) -> Bool {
        if let index = items.firstIndex(of: oldItem) {
            let result = update(newItem, at: index)
            return result
        }
        return false
    }
    
    @discardableResult
    public func update(_ item: T, at index: Int) -> Bool {
        items[index] = item
        
        do {
            try saveItemsToDocumentsDirectory()
            return true
        } catch {
            return false
        }
    }
    
    // delete
    public func deleteItem(at index: Int) throws {
        let deletedItem = items.remove(at: index)
        do {
            try saveItemsToDocumentsDirectory()
            
            //use our delegate reference to notifiy the observer of deletion
            delegate?.didDeleteItem(self, item: deletedItem)
        } catch {
            throw DataPersistenceError.deletingError
        }
    }
    
    // used for re-ordering
    public func synchronize(_ items: [T]) {
        self.items = items
        try? saveItemsToDocumentsDirectory()
    }
    
    // checks if our item has been saved
    public func hasItemBeenSaved(_ item: T) -> Bool {
        guard let items = try? loadItems() else {
            return false
        }
        
        self.items = items
        if let _ = self.items.firstIndex(of: item) {
            return true
        }
        return false
    }
    
    // remove all items from plist
    public func removeAll() {
        guard let loadedItems = try? loadItems() else {
            return
        }
        items = loadedItems
        items.removeAll()
        try? saveItemsToDocumentsDirectory()
    }
}
