//
//  SettingsViewController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/17/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
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
