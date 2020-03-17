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
    
    private var databaseService = DatabaseService()
    
    private var listener: ListenerRegistration?
    
   
    
    var apiName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieve()
//        print("current api name is \(apiName)")
//        navigationItem.title = apiName
    }

    func retrieve() {
        let ticketmaster = UserDefaults.standard.object(forKey: Keys.ticketMaster) as? String
            navigationItem.title = ticketmaster
//        let museum = UserDefaults.standard.object(forKey: Keys.museum) as? String
//        navigationItem.title = museum
    }
    
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyboardName: "LoginView", viewControllerId: "LoginViewController")
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Error signing out", message: "\(error.localizedDescription)")
            }
        }
    }
    
    
}


