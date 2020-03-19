//
//  ElementsCell.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

class ElementsCell: UITableViewCell {
    
    
    
    @IBOutlet weak var picture: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    public func configureEvent(for event: Events) {
        let imageURL = event.images.map {$0.url}.first
        guard let eventImage = URL(string: imageURL ?? "") else {
                   return
               }
        picture.kf.setImage(with: eventImage)
        titleLabel.text = event.name
        descriptionLabel.text = event.type
    }
    
    public func configureObjects(for object: Art) {
        titleLabel.text = object.title
    }

}
