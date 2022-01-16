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
    
    var superJumbo: MultiMedia? {
        return multimedia.filter {$0.format == "superJumbo"}.first
    }
}


extension HeadlinesData {
    // this function returns an array of [NewsHeadlines]
    static func getHeadlines() -> [NewsHeadline] {
        var headlines = [NewsHeadline]()
        
        // this is a url which is a path for our json file
        guard let fileUrl = Bundle.main.url(forResource: "topStoriesTechnology", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let topStoriesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
            headlines = topStoriesData.results
        } catch {
            fatalError("ok, contents failed to load\(error)")
        }
        return headlines
    }
}
