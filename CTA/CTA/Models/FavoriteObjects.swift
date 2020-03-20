//
//  FavoriteObjects.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/19/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct FavoriteObjects {
    let id: String
    let title: String
    let webImageURL: String 
}

extension FavoriteObjects {
    init?(_ dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
        let title = dictionary["title"] as? String,
        let webImageURL = dictionary["webImageURL"] as? String else {
              return nil
        }
        self.id = id
        self.title = title
        self.webImageURL = webImageURL
    }
}

