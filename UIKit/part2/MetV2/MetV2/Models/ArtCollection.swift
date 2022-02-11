//
//  ArtCollection.swift
//  MetV2
//
//  Created by Chakane Shegog on 2/10/22.
//

import Foundation


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
