//
//  PhotoModel.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/15/22.
//

import Foundation

struct Photos: Codable {
    let hits: [Hits]
}

struct Hits: Codable {
    let id: Int
    let type: String
    let webformatURL: String
    let largeImageURL: String
}
