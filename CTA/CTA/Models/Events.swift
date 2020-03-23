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
    let url: String 
    let images: [Pictures]
    let dates: Dates
    let priceRanges: [Price]
}

struct Pictures: Codable {
    let url: String
}

struct Dates: Codable {
    let start: Times
}

struct Times: Codable {
    let localDate: String
}

struct Price: Codable {
    let min: Double
    let max: Double
}

