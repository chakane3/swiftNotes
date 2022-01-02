//
//  FileManagerExtension.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 1/1/22.
//

import Foundation

extension FileManager {
    
//    FileManager grabs the directory of the users document
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    // append the filename (file.plist) to the documents directory
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
}
