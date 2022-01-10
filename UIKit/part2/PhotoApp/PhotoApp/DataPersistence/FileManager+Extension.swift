//
//  FileManager+Extension.swift
//  PhotoApp
//
//  Created by Chakane Shegog on 1/9/22.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // uses our function above to append the plist file to the users documents directory
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}

