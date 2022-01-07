//
//  DogModel.swift
//  CollectionView2
//
//  Created by Chakane Shegog on 1/6/22.
//

import Foundation

typealias DogImage = String

struct DogInfo: Codable {
    let message: [DogImage]
}

