//
//  NewsHeadline.swift
//  stories
//
//  Created by Chakane Shegog on 12/8/21.
//

import Foundation

// codable is a protocol that allows us to encode or decode our json amonst other things
struct HeadlinesData: Codable {
    let results: [NewsHeadline]
}

struct NewsHeadline: Codable {
    let title: String
    let abstract: String
    let byline: String
    let multimedia: [MultiMedia]
}

struct MultiMedia: Codable {
    let url: String
    let caption: String
    let format: String
}

extension NewsHeadline {
    var thumbImage: MultiMedia? {
        return multimedia.filter {$0.format == "thumbLarge"}.first
    }
    
    var superJumpo: MultiMedia? {
        return multimedia.filter {$0.format == "superJumpo"}.first
    }
}


extension HeadlinesData {
    
}
