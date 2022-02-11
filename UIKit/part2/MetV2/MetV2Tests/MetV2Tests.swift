//
//  MetV2Tests.swift
//  MetV2Tests
//
//  Created by Chakane Shegog on 1/29/22.
//

import XCTest
@testable import MetV2
import Foundation

class MetV2Tests: XCTestCase {
    func testExampleJSON() {
        let jsonData = """
        {
            "objectID": 840000,
            "isHighlight": false,
            "accessionNumber": "58.638.469",
            "accessionYear": "1958",
            "isPublicDomain": false,
            "primaryImage": "someImage.url",
            "primaryImageSmall": "",
            "additionalImages": [],
            "constituents": [
                {
                    "constituentID": 106211,
                    "role": "Manufacturer",
                    "name": "T. Peters and Sons",
                    "constituentULAN_URL": "",
                    "constituentWikidata_URL": "",
                    "gender": ""
                }
            ],
            "department": "Drawings and Prints",
            "objectName": "Drawings, Ornament & Architecture",
            "title": "Design for a Carriage No. 6185",
            "culture": "",
            "period": "",
            "dynasty": "",
            "reign": "",
            "portfolio": "",
            "artistRole": "Manufacturer",
            "artistPrefix": "",
            "artistDisplayName": "T. Peters and Sons",
            "artistDisplayBio": "British, active ca. 1830–1890",
            "artistSuffix": "",
            "artistAlphaSort": "Peters, T. and Sons",
            "artistNationality": "",
            "artistBeginDate": "1830",
            "artistEndDate": "1890",
            "artistGender": "",
            "artistWikidata_URL": "",
            "artistULAN_URL": "",
            "objectDate": "ca. 1830–70",
            "objectBeginDate": 1825,
            "objectEndDate": 1875,
            "medium": "Pen and black ink with watercolor, gouache (bodycolor), metallic ink and gum arabic",
            "dimensions": "Sheet: 7 7/8 × 10 5/8 in. (20 × 27 cm)",
            "measurements": [
                {
                    "elementName": "Sheet",
                    "elementDescription": null,
                    "elementMeasurements": {
                        "Height": 20,
                        "Width": 27
                    }
                }
            ],
            "creditLine": "Gift of Stewart Huston, 1958",
            "geographyType": "",
            "city": "",
            "state": "",
            "county": "",
            "country": "",
            "region": "",
            "subregion": "",
            "locale": "",
            "locus": "",
            "excavation": "",
            "river": "",
            "classification": "Drawings",
            "rightsAndReproduction": "",
            "linkResource": "",
            "metadataDate": "2021-09-04T04:36:34.737Z",
            "repository": "Metropolitan Museum of Art, New York, NY",
            "objectURL": "https://www.metmuseum.org/art/collection/search/840000",
            "tags": null,
            "objectWikidata_URL": "",
            "isTimelineWork": false,
            "GalleryNumber": ""
        }
        """.data(using: .utf8)!
        
        struct ArtCollection: Codable {
            let objectID: Int?
            let primaryImage: String?
            let primaryImageSmall: String?
            let department: String?
            let title: String?
            let culture: String?
            let country: String?
            let period: String?
            let artistDisplayName: String?
            let objectDate: Int?
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                self.objectID = try container.decodeIfPresent(Int.self, forKey: .objectID) ?? -1
                self.primaryImage = try container.decodeIfPresent(String.self, forKey: .primaryImage) ?? ""
                self.primaryImageSmall = try container.decodeIfPresent(String.self, forKey: .primaryImageSmall) ?? ""
                self.department = try container.decodeIfPresent(String.self, forKey: .department) ?? ""
                self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
                self.culture = try container.decodeIfPresent(String.self, forKey: .culture) ?? ""
                self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
                self.period = try container.decodeIfPresent(String.self, forKey: .period) ?? ""
                self.artistDisplayName = try container.decodeIfPresent(String.self, forKey: .artistDisplayName) ?? ""
                self.objectDate = try container.decodeIfPresent(Int.self, forKey: .objectDate) ?? -1
            }
        }
        
        
        
        do {
            let objectID = 840000
            let result = try JSONDecoder().decode(ArtCollection.self, from: jsonData)
            let resultID = result.objectID
            let primaryImage = result.primaryImage
            XCTAssertEqual("someImage.url", primaryImage)
        } catch {
            XCTFail("decoding error: \(error)")
        }
        
    }

}
