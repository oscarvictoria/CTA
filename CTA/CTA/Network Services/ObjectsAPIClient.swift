//
//  ObjectsAPIClient.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/17/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import NetworkHelper

struct ObjectsAPIClient {
    static func getItems(searchQuery: String, completion: @escaping (Result <[Art], AppError>)->()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "object"
        
        let endpointURLString = "https://www.rijksmuseum.nl/api/nl/collection?key=\(APIKeys.objectKey)&q=\(searchQuery)"
        
        
              
              guard let url = URL(string: endpointURLString) else {
                  completion(.failure(.badURL(endpointURLString)))
                  return
              }
              
              let request = URLRequest(url: url)
              
              NetworkHelper.shared.performDataTask(with: request) { (result) in
                  switch result {
                  case .failure(let appError):
                      completion(.failure(.networkClientError(appError)))
                  case .success(let data):
                      do {
                          let items = try JSONDecoder().decode(Items.self, from: data)
                        completion(.success(items.artObjects))
                      } catch {
                          completion(.failure(.decodingError(error)))
                      }
                  }
              }
          }
}
