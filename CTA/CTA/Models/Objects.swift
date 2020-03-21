//
//  Objects.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct Items: Codable {
    let artObjects: [Art]
}

struct Art: Codable {
    let title: String
    let id: String
    let webImage: Images
}

struct Images: Codable {
    let url: String
}


