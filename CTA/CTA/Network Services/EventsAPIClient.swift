//
//  EventsAPIClient.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import NetworkHelper

struct EventsAPIClient {
    static func getEvents(searchQuery: String, completion: @escaping (Result <[Events], AppError>)->()) {
        
         let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "event"
        
        
        let endpointURLString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=OzFgcxFTUmImDwbr5koSoyEF5TxBzwAa&city=\(searchQuery)"
        
        
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
                    let events = try JSONDecoder().decode(Embedded.self, from: data)
                    completion(.success(events._embedded.events))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
