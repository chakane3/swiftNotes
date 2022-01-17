//
//  FileManager+Extension.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/16/22.
//

import Foundation

public enum Directory {
    case documentsDirectory
    case cachesDirectory
}

extension FileManager {
    
    // returns the path to the documents directory
    public static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    public static func getCachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    // this function takes in a filename as a parameter, then appends it to the documents directory's path name and returns that path
    // The path will be used to wrtie or read data
    public static func getPath(with filename: String, for directory: Directory) -> URL {
        switch directory {
        case .cachesDirectory:
            return getCachesDirectory().appendingPathComponent(filename)
        case .documentsDirectory:
            return getDocumentsDirectory().appendingPathComponent(filename)
        }
    }
}

