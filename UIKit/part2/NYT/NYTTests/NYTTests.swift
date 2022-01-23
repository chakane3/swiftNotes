//
//  NYTTests.swift
//  NYTTests
//
//  Created by Chakane Shegog on 1/23/22.
//

import XCTest
@testable import NYT

class NYTTests: XCTestCase {
    
    // test our TopStory model
    func testTopStory() {
        // arrange
        let jsonData = """
        {
            "status": "OK",
            "copyright": "Copyright (c) 2022 The New York Times Company. All Rights Reserved.",
            "section": "Arts",
            "last_updated": "2022-01-23T15:24:20-05:00",
            "num_results": 39,
            "results": [{
                "section": "arts",
                "subsection": "television",
                "title": "Can Works Like ‘Don’t Look Up’ Get Us Out of Our Heads?",
                "abstract": "In the doomsday smash and Bo Burnham’s pandemic musical “Inside,” themes of climate change, digital distraction and inequality merge and hit home.",
                "url": "https://www.nytimes.com/2022/01/23/arts/television/dont-look-up-climate-change.html",
                "uri": "nyt://article/7eda5456-e27e-5d0b-aa2e-d08d61ebd167",
                "byline": "By Maya Salam",
                "item_type": "Article",
                "updated_date": "2022-01-23T14:30:59-05:00",
                "created_date": "2022-01-23T10:00:09-05:00",
                "published_date": "2022-01-23T10:00:09-05:00",
                "material_type_facet": "",
                "kicker": "",
                "des_facet": [
                    "Movies",
                    "Television",
                    "Global Warming",
                    "Don't Look Up (Movie)",
                    "Squid Game (TV Program)",
                    "Pam & Tommy (TV Program)",
                    "Comedy and Humor",
                    "Computers and the Internet",
                    "Inside (TV Program)"
                ],
                "org_facet": [
                    "Netflix Inc",
                    "Hulu.com"
                ],
                "per_facet": [
                    "Burnham, Bo (1990- )",
                    "Lawrence, Jennifer",
                    "DiCaprio, Leonardo"
                ],
                "geo_facet": [],
                "multimedia": [{
                    "url": "https://static01.nyt.com/images/2022/01/20/arts/00dontlookup-climate-internet1/merlin_198544002_9f0f995d-0ab8-40cd-b59e-50dd897b88be-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Leonardo DiCaprio and Jennifer Lawrence star as two scientists desperate to get the American public and its leaders to react to a planet-killing comet in “Don’t Look Up.”",
                    "copyright": "Niko Tavernise/Netflix"
                }],
                "short_url": "https://nyti.ms/32oCAi2"
            }]
        }
        """.data(using: .utf8)!
        
        
        
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
        
        // act
        let storyTitle = "Can Works Like ‘Don’t Look Up’ Get Us Out of Our Heads?"
        do {
            let topStories = try JSONDecoder().decode(TopStories.self, from: jsonData)
            
            // assert
            let supTitle = topStories.results.first?.title ?? ""
            XCTAssertEqual(storyTitle, supTitle)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
}
