//
//  DogImage.swift
//  CollectionView
//
//  Created by Chakane Shegog on 1/3/22.
//

import Foundation

typealias DogImage = String

struct DogInfo: Codable {
    let message: [DogImage]
}

