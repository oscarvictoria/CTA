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
        navigationItem.title = ""
        detailView.picture.kf.setImage(with: eventImage)
        detailView.titleLabel.text = event.name
        detailView.textView.text = event.dates.start.localDate
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
    }
    
}
