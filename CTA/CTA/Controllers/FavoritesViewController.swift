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
    
    
    private var databaseService = DatabaseService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObjects() 
        
       
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchEvents() {
        databaseService.fetchFavoriteEvents { (result) in
            switch result {
            case .failure(let error):
                print("could not get favorites \(error)")
            case .success(let events):
                dump(events)
            }
        }
    }
    
    private func fetchObjects() {
        databaseService.fetchFavoriteObjects { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let favorites):
                dump(favorites)
            }
        }
    }
    

 

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
}
