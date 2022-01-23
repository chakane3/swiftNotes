//
//  TopStories.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import Foundation

struct TopStories: Codable {
    let section: String
    let lastUpdated: String
    let results: [Article]
    private enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case results
        case section
    }
}

struct Article: Codable {
    let section: String
    let subsection: String
    let abstract: String
    let title: String
    let publishedDate: String
    let multimedia: [MultiMedia]
    
    private enum CodingKeys: String, CodingKey {
        case section
        case subsection
        case abstract
        case title
        case publishedDate = "published_date"
        case multimedia
    }
}

struct MultiMedia: Codable {
    let url: String
    let format: String
    let height: Double
    let width: Double
    let caption: String
}
