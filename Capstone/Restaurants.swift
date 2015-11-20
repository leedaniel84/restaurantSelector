//
//  Restaurants.swift
//  Capstone
//
//  Created by Daniel Lee on 11/16/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import Foundation

class Restaurants {
    var name: String
    var rating: Float
    var phone: String
    var categories: String
    var location: String
    
    init(json: [String: AnyObject]) {
       
        guard let name = json["name"] as? String,
        let rating = json["rating"] as? Float,
        let phone = json["phone"] as? String,
        let categories = json["categories"] as? String,
        let location = json["location"] as? String else {
            
            self.name = ""
            self.rating = 0
            self.phone = ""
            self.categories = ""
            self.location = ""
            return
        }
        
        self.name = name
        self.rating = rating
        self.phone = phone
        self.categories = categories
        self.location = location
    }
    
}

