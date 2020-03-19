//
//  UIimage + Extensions.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/18/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

struct ImageClient {
    // takes in a url string uses a completion handler to capture processed image from the url source e.g "https://...jpg"
    
    // we connot simply return an image from this function
    // why?
    // because URLSession performs an asynchronous network call,
    // which means the call relies on the network and is done on the background, not performed instantanously
    
    static func fetchImage(for urlString: String,
                           completion: @escaping (Result<UIImage?, Error>) -> ()) {
        // validate it is a valid url
        guard let url = URL(string: urlString) else {
            print("bad url \(urlString)")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check if an error exist
            if let error = error {
                print("error: \(error)")
                // TODO: add enum error
            }
            
            // TODO: check for valid status code of 200...299
            
            // TODO: check for valid mime type of image\jpeg
            
            if let data = data {
                // use data to create an image
                let image = UIImage(data: data)
                // capture result of image
                completion(.success(image))
            }
        }
        dataTask.resume() // invokes network request
    }
}

