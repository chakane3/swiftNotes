//
//  Persistence.swift
//  PhotoApp
//
//  Created by Chakane Shegog on 1/9/22.
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
    
    // we need to make use of an empty array
    private var photos = [ImageObject]()
    
    private var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private func save() throws {
        
        // get url path to the file that the photo will be saved to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // the photos array will be the object being converted into Data
        // we will use the data object and write it to the documents directory
        do {
            // encode the events array to Data
            let data = try PropertyListEncoder().encode(photos)
            
            // writes the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            
            // ran into a problem of encoding
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // re-ordering
    public func sync(photos: [ImageObject]) {
        self.photos = photos
    }
    
    // this function will save a photo to the documents directory
    public func create(photos: ImageObject) throws {
        // append the new photo to the photos array
        self.photos.append(photos)
        
        do {
            try save()
        } catch {
            
            // ran into a problem is saving after we apended the photo
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // this function loads items from the documents directory
    public func loadItems() throws -> [ImageObject] {
        // we need the filename URL were reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if the file exists
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    photos = try PropertyListDecoder().decode([ImageObject].self, from: data)
                } catch {
                    
                    // ran into an error of decoding our PropertyList
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                // no data in our file
                throw DataPersistenceError.noData
            }
        } else {
            // file did not exist
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        
        return photos
    }
    
    // this function deletes phoos from the documents directory
    public func delete(item index: Int) throws {
        // remove from the photos array
        photos.remove(at: index)
        
        // save the array to reflect the change
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
