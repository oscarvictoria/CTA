//
//  DatabaseService.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

private let db = Firestore.firestore() // reference to FirebaseFirestore database

class DatabaseService {
    
    static let usersCollection = "users"
    
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result <Bool, Error>)->()) {
        
        guard let email = authDataResult.user.email else {
                  return
              }
        db.collection(DatabaseService.usersCollection).document(authDataResult.user.uid).setData(["email" : email, "createdDate": Timestamp(date: Date()), "userId": authDataResult.user.uid]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    
    public func updateDatabaseUser(userAPI: String, completion: @escaping (Result <Bool, Error>)->()) {
        
        guard let user = Auth.auth().currentUser else {
                 return
             }
        
        db.collection(DatabaseService.usersCollection).document(user.uid).updateData(["userAPI" : userAPI]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    
    
}
