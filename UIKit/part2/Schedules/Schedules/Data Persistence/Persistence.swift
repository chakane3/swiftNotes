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
    case deletingError
    case noContentsAtPath(String)
    case writingError(Error)
    case propertyListDecodingError(Error)
}


// define our custom protocol
protocol DataPersistenceDelegate: AnyObject {
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T)
}

typealias Writeable = Codable & Equatable

// DataPersistence is now constrained to only work with Codable types
class DataPersistence<T: Writeable> {
    private let filename: String
    private var items: [T]
    
    // definite a reference property that will be registered at the object listening on notifications.
    // we use "weak" to break a strong reference between the delegate object and the DataPersistenc class
    weak var delegate: DataPersistenceDelegate?
    
    public init(filename: String) {
        self.filename = filename
        self.items = []
    }
    
    private func saveItemsToDocumentsdirectory() throws {
        do {
            let url = FileManager.getPath(with: filename, for: .documentsDirectory)
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.writingError(error)
        }
    }
    
    public func createItem(_ item: T) throws {
        _ = try? loadItems()
        items.append(item)
        do {
            try saveItemsToDocumentsdirectory()
        } catch {
            throw DataPersistenceError.writingError(error)
        }
    }
    
    public func loadItems() throws -> [T] {
        let path = FileManager.getPath(with: filename, for: .documentsDirectory).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([T].self, from: data)
                } catch {
                    throw DataPersistenceError.propertyListDecodingError(error)
                }
            }
        }
        return items
    }
    
    
    // for reordering
    public func synchroize(_ items: [T]) {
        self.items = items
        try? saveItemsToDocumentsdirectory()
    }
    
    // update
    @discardableResult // this silences the warning if the return value is not used by the caller
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
        // save items to the documents directory
        do {
            try saveItemsToDocumentsdirectory()
            return true
        } catch {
            return false
        }
    }
    
    // delete
    public func deleteItems(at index: Int) throws {
        let deletedItem = items.remove(at: index)
        do {
            try saveItemsToDocumentsdirectory()
            // use our custom delegate reference to notify observer of deletion
            delegate?.didDeleteItem(self, item: deletedItem)
        } catch {
            throw DataPersistenceError.deletingError
        }
    }
    
    public func hasBeenSaved(_ item: T) -> Bool {
        guard let items = try? loadItems() else {
            return false
        }
        self.items = items
        if let _ = self.items.firstIndex(of: item) {
            return true
        }
        return false
    }
    
    public func removeAll() {
        guard let loadedItems = try? loadItems()  else {
            return
        }
        items = loadedItems
        items.removeAll()
        try? saveItemsToDocumentsdirectory()
    }
}

