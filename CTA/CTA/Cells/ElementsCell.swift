//
//  ElementsCell.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

protocol RemoveObjectDelegate: AnyObject {
    func favoriteButtonPressed(_ elementCell: ElementsCell)
}

protocol RemoveFavoriteDelegate: AnyObject {
    func buttonPressed(_ elementCell: ElementsCell)
}

protocol FavoriteCellDelegate: AnyObject {
    func favoriteButtonPressed(_ elementsCell: ElementsCell)
}

protocol FavoriteObjectDelegate: AnyObject {
    func favoriteButton(_ elementCell: ElementsCell)
}

class ElementsCell: UITableViewCell {
    
    var removeObjectsDelegate: RemoveObjectDelegate?
    
    var removeFavoriteDelegate: RemoveFavoriteDelegate?
    
    var delegate: FavoriteCellDelegate?
    
    var objectDelegate: FavoriteObjectDelegate?
    
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
        descriptionLabel.text = event.dates.start.localDate
        
    }
    
    public func configureObjects(for object: Art) {
        guard let objectImage = URL(string: object.webImage.url ) else {
            return
        }
        picture.kf.setImage(with: objectImage)
        titleLabel.text = object.title
        descriptionLabel.text = ""
    }
    
    public func configureFavoriteEvents(for event: FavoriteEvents) {
        guard let eventImage = URL(string: event.imageURL) else {
            return
        }
        picture.kf.setImage(with: eventImage)
        titleLabel.text = event.name
        descriptionLabel.text = event.date
    }
    
    public func configureFavoriteObject(for object: FavoriteObjects) {
        guard let objectImage = URL(string: object.webImageURL ) else {
            return
        }
        
        picture.kf.setImage(with: objectImage)
        titleLabel.text = object.title
        descriptionLabel.text = ""
    }
    
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        delegate?.favoriteButtonPressed(self)
        objectDelegate?.favoriteButton(self)
        removeFavoriteDelegate?.buttonPressed(self)
        removeObjectsDelegate?.favoriteButtonPressed(self)
    }
    
    
    
    
}
