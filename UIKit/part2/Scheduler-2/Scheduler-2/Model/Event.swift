//
//  Event.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/16/22.
//

import Foundation

struct Event: Codable & Equatable {
    let identifier = UUID().uuidString
    var date: Date
    var name: String
}
