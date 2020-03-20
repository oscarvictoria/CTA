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
    
    private var databaseService = DatabaseService()
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func continueLoginFlow(email: String, password: String) {
        if accountState == .existingUser  {
            authSession.signExistingUser(email: email, password: password) { (result) in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                case .success:
                    DispatchQueue.main.async {
                        self.selectAPI()
                    }
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { (result) in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                case .success(let authDataResult):
                    self.createDatabaseUser(authDataResult: authDataResult)
                }
            }
        }
    }
    
    //
    private func createDatabaseUser(authDataResult: AuthDataResult) {
        databaseService.createDatabaseUser(authDataResult: authDataResult) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Account Error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self.selectAPINewUser()
                }
            }
        }
    }
    
    public func selectAPI() {
        guard let apiController = storyboard?.instantiateViewController(identifier: "SelectAPIController") as? SelectAPIController else {
            fatalError("could not downcast to SelectAPIController")
        }
        apiController.accountState = .existingUser
        apiController.modalPresentationStyle = .fullScreen
        apiController.modalTransitionStyle = .crossDissolve
        present(apiController, animated: true)
    }
    
    public func selectAPINewUser() {
        guard let apiController = storyboard?.instantiateViewController(identifier: "SelectAPIController") as? SelectAPIController else {
            fatalError("could not downcast to SelectAPIController")
        }

        apiController.accountState = .newUser
        apiController.modalPresentationStyle = .fullScreen
        apiController.modalTransitionStyle = .crossDissolve
        present(apiController, animated: true)
    }
    
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
//        print("login button pressed")
        continueLoginFlow(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        print("create account button pressed")
        accountState = accountState == .existingUser ? .newUser : .existingUser
        continueLoginFlow(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    
    
    
}
