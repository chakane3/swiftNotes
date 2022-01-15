//
//  FileManager+Extension.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation

extension FileManager {
    // know the difference between a type and an instance method
    // let fileManager = FileManager()
    // fileManager.etDocumentsDirectory() <- instance
    
    // FileManager.getDocumentsDirectory <- type method
    
    // this function grabs the users path to the documents directory
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // this function appends the users documents directory to the rest of the path needed
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
