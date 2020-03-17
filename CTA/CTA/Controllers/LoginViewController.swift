//
//  LoginViewController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
    case existingUser
    case newUser
}

enum UserAPI {
    case ticketMaster
    case museum
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    private var accountState: AccountState = .existingUser
    
    private var userAPI: UserAPI = .ticketMaster
    
    //    private var databaseService = DatabaseService()
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    public func selectAPI() {
        guard let apiController = storyboard?.instantiateViewController(identifier: "SelectAPIController") as? SelectAPIController else {
            fatalError("could not downcast to SelectAPIController")
        }
        apiController.email = emailTextField.text ?? ""
        apiController.password = passwordTextField.text ?? ""
        apiController.accountState = .existingUser
        apiController.modalPresentationStyle = .popover
//        apiController.modalTransitionStyle = .crossDissolve
        present(apiController, animated: true)
    }
    
    public func selectAPINewUser() {
        guard let apiController = storyboard?.instantiateViewController(identifier: "SelectAPIController") as? SelectAPIController else {
            fatalError("could not downcast to SelectAPIController")
        }
        apiController.email = emailTextField.text ?? ""
        apiController.password = passwordTextField.text ?? ""
        apiController.accountState = .newUser
        apiController.modalPresentationStyle = .popover
//        apiController.modalTransitionStyle = .crossDissolve
        present(apiController, animated: true)
    }
    
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("login button pressed")
        selectAPI()
    }
    
    
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        print("create account button pressed")
        selectAPINewUser()
    }
    
    
}
