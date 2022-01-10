//
//  ImageObject.swift
//  PhotoApp
//
//  Created by Chakane Shegog on 1/9/22.
//

import Foundation

struct ImageObject: Codable {
    let imageData: Data
    let date: Date
    
    // this lets us identify our object - UUID is a class
    let identifier = UUID().uuidString
}
