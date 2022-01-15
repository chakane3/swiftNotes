//
//  FileManager+Extension.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation

public enum Directory {
    case documentsDirectory
    case cachesDirectory
}

extension FileManager {
    // know the difference between a type and an instance method
    // let fileManager = FileManager()
    // fileManager.etDocumentsDirectory() <- instance
    
    // FileManager.getDocumentsDirectory <- type method
    
    // this function grabs the users path to the documents directory
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    public static func getCachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    // this function appends the users documents directory to the rest of the path needed
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
    
    // this function takes a filename as a parameter, appends to the document directory's url and returns
    // the path where we write or read data.
    public static func getPath(with filename: String, for directory: Directory) -> URL {
        switch directory {
        case .cachesDirectory:
            return getCachesDirectory().appendingPathComponent(filename)
        case .documentsDirectory:
            return getDocumentsDirectory().appendingPathComponent(filename)
        }
    }
}
