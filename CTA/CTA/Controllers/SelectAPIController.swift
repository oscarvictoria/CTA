//
//  SelectAPIController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth

struct Keys {
    static let ticketMaster = "ticketMaster"
    static let museum = "museum"
}

class SelectAPIController: UIViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    private var authSession = AuthenticationSession()
    
    private var databaseService = DatabaseService()
    
    var accountState: AccountState = .existingUser
    
    private var userAPI: UserAPI = .ticketMaster
    
    private let list = ["ticketmaster", "Musuem"]
    
    public var apiNumber = Int()
    
    var listName: String!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        listName = list.first
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        updateAPI()
        defaults.set(listName, forKey: Keys.ticketMaster)
        if apiNumber == 0 {
            UserDefaults.standard.set(true, forKey: "status")
            Switcher.updateRootVC()
        } else if apiNumber == 1 {
            UserDefaults.standard.set(false, forKey: "status")
            Switcher.updateRootVC()
        }
    }
    
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
    
    func segueToMainView() {
        UIViewController.showViewController(storyboardName: "MainView", viewControllerId: "MainTabBarController")
    }
    
    
    
    
    
    
    
    
    
    
    
}

extension SelectAPIController: UIPickerViewDataSource {
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

extension SelectAPIController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
}
