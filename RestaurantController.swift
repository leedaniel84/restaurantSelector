//
//  RestaurantController.swift
//  Capstone
//
//  Created by Daniel Lee on 11/19/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import Foundation

class RestaurantController {
    
    var restaurantArray: [Restaurants] = []
    
    func searchForRestaurant(searchTerm: String, completion: (success: Bool) -> Void) {
        
        let url = NetworkController.baseURL(searchTerm)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            
            guard let data = resultData else {
                print("No Data Returned")
                completion(success: false)
                return
            }
            
            do {
                let resultsAnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                
                if let resultsDictionary = resultsAnyObject as? [String: AnyObject] {
                    
                    if let resultsArray = resultsDictionary["results"] as? [[String: AnyObject]] {
                        
                        for restaurantDictionary in resultsArray {
                            let restaurant = Restaurants(json: restaurantDictionary)
                            self.restaurantArray.append(restaurant)
                        }
                        
                        completion(success: true)
                    } else {
                        completion(success: false)
                    }
                }
            } catch {
                completion(success: false)
            }
        }
        
    }
}
