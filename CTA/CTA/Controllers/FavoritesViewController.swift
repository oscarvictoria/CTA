//
//  FavoritesViewController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/17/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseFirestore

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var apiName = String()
    
    
    private var databaseService = DatabaseService()
    
    var event = [FavoriteEvents]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var objects = [FavoriteObjects]() {
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
        fetchEvents()
        fetchObjects()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ElementsCell", bundle: nil), forCellReuseIdentifier: "elementsCell")
    }
    
    private func fetchEvents() {
        databaseService.fetchFavoriteEvents { (result) in
            switch result {
            case .failure(let error):
                print("could not get favorites \(error)")
            case .success(let events):
                self.event = events
            }
        }
    }
    
    private func fetchObjects() {
        databaseService.fetchFavoriteObjects { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let favorites):
                self.objects = favorites
            }
        }
    }
    
    func retrieve() {
        let ticketmaster = UserDefaults.standard.object(forKey: Keys.ticketMaster) as? String
        navigationItem.title = ticketmaster
    }
    
    
    
    
    
}

extension FavoritesViewController: UITableViewDataSource {
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
            cell.removeFavoriteDelegate = self
            cell.configureFavoriteEvents(for: events)
        } else if navigationItem.title == "Musuem" {
            let object = objects[indexPath.row]
            cell.removeObjectsDelegate = self
            cell.configureFavoriteObject(for: object)
        }
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension FavoritesViewController: RemoveFavoriteDelegate {
    func buttonPressed(_ elementCell: ElementsCell) {
        guard let indexPath = tableView.indexPath(for: elementCell) else {
                return
            }
            
            let events = event[indexPath.row]
        databaseService.removeFavorite(for: events) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(title: "Item removed", message: nil)
                }
            }
        }
        
    }
}

extension FavoritesViewController: RemoveObjectDelegate {
    func favoriteButtonPressed(_ elementCell: ElementsCell) {
        guard let indexPath = tableView.indexPath(for: elementCell) else {
                 return
             }
             
        let object = objects[indexPath.row]
        databaseService.removeFavoriteObject(for: object) { (result ) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(title: "Item removed", message: nil)
                }
            }
        }
    }
    
    
}

