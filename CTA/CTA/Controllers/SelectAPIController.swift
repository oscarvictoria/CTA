//
//  SelectAPIController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class SelectAPIController: UIViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var authSession = AuthenticationSession()
    
//    private var databaseService = DatabaseService()
    
    var accountState: AccountState = .existingUser
    
    private let list = ["ticketmaster", "Musuem"]
    
    let email = String()
    
    let password = String()
    
    
    private var listName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        listName = list.first
        print("current account state is: \(accountState)")
        
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
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
//         userAPI = userAPI == .ticketMaster ? .museum : .ticketMaster
//         if listName == list[0] {
//             userAPI = .ticketMaster
//             apiNumber = 0
//         } else if listName == list[1] {
//             userAPI = .museum
//             apiNumber = 1
//         }
//
         
     }
    
    
    
    
}

extension SelectAPIController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return list[row]
       }
}
