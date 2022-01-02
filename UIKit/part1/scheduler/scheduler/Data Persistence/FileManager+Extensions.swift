//
//  FileManager+Extensions.swift
//  scheduler
//
//  Created by Chakane Shegog on 12/7/21.
//

import Foundation

// here we want to include a new function for FileManager
extension FileManager {
    // we can use the file manager to grab the directory of our users document.
    
    // note that removing static func this function will force us to make an
    // instance of let fileManager = FileManager(); static creates an instance for us.
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // this helper function appends a filename to the documents directory
    // i.e documents/yourFile.plist
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
        
}
