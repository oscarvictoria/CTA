//
//  FavoriteEvents.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/19/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct FavoriteEvents {
    let name: String
    let type: String
    let id: String
    let date: String
    let imageURL: String
}

extension FavoriteEvents {
    init?(_ dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
        let type = dictionary["type"] as? String,
        let id = dictionary["id"] as? String,
        let date = dictionary["date"] as? String,
        let imageURL = dictionary["imageURL"] as? String else {
            return nil
        }
        self.name = name
        self.type = type
        self.id = id
        self.date = date
        self.imageURL = imageURL
    }
}


