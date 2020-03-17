//
//  Events.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct Embedded: Codable {
    let _embedded: EventData
}
struct EventData: Codable {
    let events: [Events]
}

struct Events: Codable {
    let name: String
    let type: String
    let id: String
}
