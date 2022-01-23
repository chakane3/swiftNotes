//
//  Persistence.swift
//  UserHoroscope
//
//  Created by Chakane Shegog on 1/23/22.
//

import Foundation
import UIKit

enum PersistenceError: Error {
    case encodingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

enum UserDefaultsState {
    case userDefaultsExists
    case userDefaultsDoesNotExist
}

class Persistence {
    private var userBirthday = [UserBirthday]()
    private var filename: String
    private var defaults = UserDefaultsState.userDefaultsExists
    init(filename: String) {
        self.filename = filename
    }
    
    private func save() throws {
        // get url path of the file that the photo will be saved to
        let url = FileManager.getPath(with: filename)
        
        // the photos array will be the object being converted into data
        // we will use the data object and write it to the documents directory
        do {
            // encode the events array to data and write it to our file
            let data = try PropertyListEncoder().encode(userBirthday)
            try data.write(to: url, options: .atomic)
        } catch {
            throw PersistenceError.encodingError(error)
        }
    }
    
    public func create(birthday: UserBirthday) throws {
        if self.userBirthday.count == 0 {
            defaults = UserDefaultsState.userDefaultsDoesNotExist
            
        }
        self.userBirthday.append(birthday)
    }
}
