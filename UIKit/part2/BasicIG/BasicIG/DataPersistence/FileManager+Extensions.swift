//
//  FileManager+Extensions.swift
//  BasicIG
//
//  Created by Chakane Shegog on 1/2/22.
//

import Foundation


extension FileManager {
    
    // returns a URL to the documents directory for the app
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // this function takes in a filename as input and then append that name to the users docyments directory
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
