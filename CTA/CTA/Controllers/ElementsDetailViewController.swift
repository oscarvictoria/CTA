//
//  ElementsDetailViewController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/18/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

class ElementsDetailViewController: UIViewController {
    
    
    var detailView = DetailView()
    
    var events: Events?
    
    var objects: Art?
    
    private var databaseService = DatabaseService()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        retrieve()
        configureView()
        
    }
    
    func retrieve() {
        let ticketmaster = UserDefaults.standard.object(forKey: Keys.ticketMaster) as? String
        navigationItem.title = ticketmaster
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
    }
    
    func configureView() {
        if navigationItem.title == "ticketmaster" {
            updateUI()
        } else if navigationItem.title == "Musuem" {
            updateObjectUI()
        }
    }
    
    func updateUI() {
        guard let event = events else {
            fatalError("could not get event")
        }
        let imageURL = event.images.map {$0.url}.first
        guard let eventImage = URL(string: imageURL ?? "") else {
            return
        }
        detailView.picture.kf.setImage(with: eventImage)
        detailView.titleLabel.text = event.name
        detailView.favoriteButton.addTarget(self, action: #selector(addEventToFavorites), for: .touchUpInside)
        var min = 0.0
        var max = 0.0
        for item in event.priceRanges {
            min = item.min
            max = item.max
        }
        
        detailView.textView.text = """
        Date: \(event.dates.start.localDate)
        
        Price: $\(min.description) - $\(max.description)
        
        
        URL: \(event.url)
        
        """
        
        
    }
    
    func updateObjectUI() {
        guard let object = objects else {
            fatalError("could not get objects")
        }
        
        guard let objectImage = URL(string: object.webImage.url ) else {
            return
        }
        
        detailView.picture.kf.setImage(with: objectImage)
        detailView.titleLabel.text = object.title
        ObjectsAPIClient.getDetails(objectNumber: object.objectNumber) { (result) in
            switch result {
            case .failure(let appError):
                print("appError \(appError)")
            case .success(let string):
                DispatchQueue.main.async {
                    self.detailView.textView.text = string
                }
            }
        }
        detailView.favoriteButton.addTarget(self, action: #selector(addObjectsToFavorites), for: .touchUpInside)
    }
    
    @objc func addEventToFavorites() {
        databaseService.isEventInFavorites(for: events!) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let success):
                if success {
                    self.databaseService.removeEvent(for: self.events!) { (result) in
                        switch result {
                        case .failure(let error):
                            print("error \(error)")
                        case .success:
                            DispatchQueue.main.async {
                                self.showAlert(title: "Item removed from favorites", message: nil)
                            }
                        }
                    }
                } else {
                    self.databaseService.addFavortiteEvents(event: self.events!) { (result) in
                        switch result {
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showAlert(title: "Could not favorite item", message: error.localizedDescription)
                            }
                        case .success:
                            DispatchQueue.main.async {
                                self.showAlert(title: "Item added to favorites", message: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func addObjectsToFavorites() {
        databaseService.isObjectInFavorites(for: objects!) { (result) in
            switch result {
            case .failure(let error):
                print("appError \(error)")
            case .success(let success):
                if success {
                    self.databaseService.removeObject(for: self.objects!) { (result) in
                        switch result {
                        case .failure(let error):
                            print("could not remove item \(error)")
                        case .success:
                            DispatchQueue.main.async {
                                self.showAlert(title: "Item removed from favorties", message: nil)
                            }
                        }
                    }
                } else {
                    self.databaseService.addFavoriteObjects(objects: self.objects!) { (result) in
                        switch result {
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showAlert(title: "Could not add object to favorites", message: error.localizedDescription)
                            }
                        case .success:
                            DispatchQueue.main.async {
                                self.showAlert(title: "Object added to favorites", message: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
