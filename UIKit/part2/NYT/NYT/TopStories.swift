//
//  TopStories.swift
//  NYT
//
//  Created by Chakane Shegog on 1/23/22.
//

import Foundation

enum ImageFormat: String {
    case superJumbo = "superJumbo"
    case thumbLarge = "thumbLarge"
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal"
}

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
    let abstract: String
    let title: String
    let publishedDate: String
    let multimedia: [MultiMedia]?
    
    private enum CodingKeys: String, CodingKey {
        case section
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

extension Article {
    func getArticleImageURL(for imageFormat: ImageFormat) -> String {
        guard let multimedia = multimedia else { return "" }
        let results = multimedia.filter {$0.format == imageFormat.rawValue}
        guard let multimediaImage = results.first else {
            return ""
        }
        return multimediaImage.url
    }
}
