//
//  RandomUser.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/5/22.
//

import Foundation

struct RandomUsers: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable {
    let name: NameInfo
    let location: LocationInfo
    let email: String
    let picture: ImageInfo
}

struct NameInfo: Codable {
    let first: String
    let last: String
    let title: String
}

struct LocationInfo: Codable {
    let city: String
    let state: String
    let country: String
}

struct ImageInfo: Codable {
    let thumbnail: String
    let medium: String
}

