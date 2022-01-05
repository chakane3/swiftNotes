//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct Message {
    var userID: Int
    var username: String
    var avatarURL: URL?
    var text: String
    
    init(testName: String, withTestMessage message: String) {
        self.userID = 0
        self.username = testName
        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
        self.text = message
    }
}
