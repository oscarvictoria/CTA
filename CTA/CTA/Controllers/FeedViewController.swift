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
    
    private var listener: ListenerRegistration?
    
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
        getItems()
        getEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
            cell.configureEvent(for: events)
        } else if navigationItem.title == "Musuem" {
            let object = objects[indexPath.row]
            cell.configureObjects(for: object)
        }
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
