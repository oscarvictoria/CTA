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
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var databaseService = DatabaseService()
    
    
    private var userAPI: UserAPI = .ticketMaster
    
    var listName: String!
    
    public var apiNumber = Int()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private let list = ["ticketmaster", "Musuem"]
    
    func updateAPI() {
        databaseService.updateDatabaseUser(userAPI: listName) { (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success:
                print("succesfully updated user api")
            }
        }
    }
    
    
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        defaults.set(listName, forKey: Keys.ticketMaster)
        updateAPI()
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

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        listName = list[row]
        print(listName!)
        userAPI = userAPI == .ticketMaster ? .museum : .ticketMaster
        if listName == list[0] {
            userAPI = .ticketMaster
            apiNumber = 0
        } else if listName == list[1] {
            userAPI = .museum
            apiNumber = 1
        }
        
    }
    
    
    
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
}
