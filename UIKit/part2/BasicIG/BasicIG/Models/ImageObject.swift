//
//  ImageObject.swift
//  BasicIG
//
//  Created by Chakane Shegog on 1/2/22.
//

import Foundation

struct ImageObject: Codable {
    let imageData: Data
    let date: Date
    
    // UUIS() is a universally unique value that can be used to identify types, interfaces, and other items.
    var identifier = UUID().uuidString
}
