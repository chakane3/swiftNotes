//
//  FileManager+Extensions.swift
//  UserHoroscope
//
//  Created by Chakane Shegog on 1/21/22.
//

import Foundation

extension FileManager {
    
    // returns the path of the documents directory
    public static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // append our plist filename to the documents directory
    // this is the path we will read/write to
    public static func getPath(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
