//
//  FeedViewController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/17/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var databaseService = DatabaseService()
    
    private var isFavorite = false {
        didSet {
            if isFavorite {
                
            } else {
                
            }
        }
    }
    
    var apiName = String()
    
    var event = [Events]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var objects = [Art]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        retrieve()
        configureTableView()
        getItems()
        getEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func retrieve() {
        let ticketmaster = UserDefaults.standard.object(forKey: Keys.ticketMaster) as? String
        navigationItem.title = ticketmaster
        //        let museum = UserDefaults.standard.object(forKey: Keys.museum) as? String
        //        navigationItem.title = museum
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ElementsCell", bundle: nil), forCellReuseIdentifier: "elementsCell")
    }
    
    func getEvents() {
        EventsAPIClient.getEvents(searchQuery: "Seattle") { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let event):
                self.event = event
            }
        }
    }
    
    func getItems() {
        ObjectsAPIClient.getItems { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let art):
                self.objects = art
            }
        }
    }
    
    func setUI(for cell: ElementsCell, for events: Events) {
        databaseService.isEventInFavorites(for: events) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let success):
                if success {
                    cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        }
    }
    
    func setUIObjects(for cell: ElementsCell, for object: Art) {
        databaseService.isObjectInFavorites(for: object) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let success):
                if success {
                    cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationItem.title == "ticketmaster" {
            //             print("current api is ticketmaster and the count is \(event.count)")
            return event.count
        } else {
            //             print("current api is museum and the count is \(objects.count)")
            return objects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementsCell", for: indexPath) as? ElementsCell else {
            fatalError("could not get cell")
        }
        
        if navigationItem.title == "ticketmaster" {
            let events = event[indexPath.row]
            cell.delegate = self
            cell.configureEvent(for: events)
            setUI(for: cell, for: events)
            
        } else if navigationItem.title == "Musuem" {
            let object = objects[indexPath.row]
            cell.objectDelegate = self
            cell.configureObjects(for: object)
            setUIObjects(for: cell, for: object)
        }
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ElementsDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FeedViewController: FavoriteCellDelegate {
    func favoriteButtonPressed(_ elementsCell: ElementsCell) {
        guard let indexPath = tableView.indexPath(for: elementsCell) else {
            return
        }
        
        let events = event[indexPath.row]
        
        databaseService.isEventInFavorites(for: events) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let success):
                if success {
                    self.databaseService.removeEvent(for: events) { (result) in
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
                    self.databaseService.addFavortiteEvents(event: events) { (result) in
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
    
}

extension FeedViewController: FavoriteObjectDelegate {
    func favoriteButton(_ elementCell: ElementsCell) {
        
        guard let indexPath = tableView.indexPath(for: elementCell) else {
            return
        }
        let object = objects[indexPath.row]
        
        databaseService.isObjectInFavorites(for: object) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let success):
                if success {
                    self.databaseService.removeObject(for: object) { (result) in
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
                    self.databaseService.addFavoriteObjects(objects: object) { (result) in
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
