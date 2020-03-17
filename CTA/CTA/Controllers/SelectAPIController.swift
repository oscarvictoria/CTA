//
//  SelectAPIController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth

class SelectAPIController: UIViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var userSession = UserSession()
    
    private var authSession = AuthenticationSession()
    
    private var databaseService = DatabaseService()
    
    var accountState: AccountState = .existingUser
    
    private let list = ["ticketmaster", "Musuem"]
    
    var listName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        listName = list.first
        print("current account state is: \(accountState)")
        
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        updateAPI()
        sendAPI()
        segueToMainView()
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
    
    func sendAPI() {
       
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
    }
    
    
    
    
}

extension SelectAPIController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
}
