//
//  AuthenticationSession.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthenticationSession {
    
    public func createNewUser(email: String, password: String, completion: @escaping (Result <AuthDataResult, Error>)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authDataResult = authDataResult {
                completion(.success(authDataResult))
            }
        }
    }
    
    public func signExistingUser(email: String, password: String, completion: @escaping (Result <AuthDataResult, Error>)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authDataResult = authDataResult {
                completion(.success(authDataResult))
            }
        }
    }
}
