//
//  EventsDetail.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/21/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct ObjectsDetail: Codable {
    let artObject: Details
}

struct Details: Codable {
    let plaqueDescriptionEnglish: String 
}
