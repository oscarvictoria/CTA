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
    
    static let favoriteEvents = "favoriteEvents"
    
    static let favoriteObjects = "favoriteObjects"
    
    
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
    
    public func addFavortiteEvents(event: Events, completion: @escaping (Result <Bool, Error>)->()) {
        
        db.collection(DatabaseService.favoriteEvents).document(event.id).setData(["name" : event.name, "type": event.type, "id": event.id, "imageURL": event.images.map {$0.url}.first!, "date": event.dates.start.localDate]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    
    public func addFavoriteObjects(objects: Art, completion: @escaping (Result <Bool, Error>)->()) {
        db.collection(DatabaseService.favoriteObjects).document(objects.id).setData(["id": objects.id, "title": objects.title, "webImageURL": objects.webImage.url]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func fetchFavoriteEvents(completion: @escaping (Result <[FavoriteEvents], Error>)->()) {
        db.collection(DatabaseService.favoriteEvents).getDocuments { (snapShot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapShot = snapShot {
                let favorites = snapShot.documents.compactMap {FavoriteEvents($0.data())}
                completion(.success(favorites))
            }
        }
    }
    
    public func fetchFavoriteObjects(completion: @escaping (Result <[FavoriteObjects], Error>)->()) {
        db.collection(DatabaseService.favoriteObjects).getDocuments { (snapShot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapShot = snapShot {
                let favorties = snapShot.documents.compactMap {FavoriteObjects($0.data())}
                completion(.success(favorties))
            }
        }
    }
    
    public func removeEvent(for event: Events, completion: @escaping (Result <Bool, Error>)->()) {
        db.collection(DatabaseService.favoriteEvents).document(event.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func removeFavorite(for event: FavoriteEvents, completion: @escaping (Result <Bool, Error>)->()) {
        db.collection(DatabaseService.favoriteEvents).document(event.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func removeObject(for object: Art, completion: @escaping (Result <Bool, Error>)->()) {
        db.collection(DatabaseService.favoriteObjects).document(object.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func removeFavoriteObject(for object: FavoriteObjects, completion: @escaping (Result <Bool, Error>)->()) {
          db.collection(DatabaseService.favoriteObjects).document(object.id).delete { (error) in
              if let error = error {
                  completion(.failure(error))
              } else {
                  completion(.success(true))
              }
          }
      }
    
    public func isEventInFavorites(for event: Events, completion: @escaping (Result <Bool, Error>)->()) {
        
        db.collection(DatabaseService.favoriteEvents).whereField("id", isEqualTo: event.id).getDocuments { (snapShot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapShot = snapShot {
                let count = snapShot.documents.count
                if count > 0 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            }
        }
    }
    
    public func isObjectInFavorites(for object: Art, completion: @escaping (Result <Bool, Error>)->()) {
        
        db.collection(DatabaseService.favoriteObjects).whereField("id", isEqualTo: object.id).getDocuments { (snapShot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapShot = snapShot {
                let count = snapShot.documents.count
                if count > 0 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            }
        }
    }
    
    
}
