//
//  RestaurantController.swift
//  Capstone
//
//  Created by Daniel Lee on 11/19/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import Foundation
import MapKit

class RestaurantController {
    
    static let sharedController = RestaurantController()

    static func getRestaurants(location: CLLocation, completion: (restaurants: [Restaurant]) -> Void) {
        
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Restaurants"
        request.region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1600, 1600)
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) -> Void in
            guard let response = response else {
                print("Search Error \(error?.localizedDescription)")
                return
            }
            
            var arrayOfRestaurants = [Restaurant]()
            for item in response.mapItems {
                print(item)
                guard let name = item.name,
                    let phone = item.phoneNumber,
                    let url = item.url else {
                    continue
                }
                
                let newRestaurant = Restaurant(name: name, placemark: item.placemark, phone: item.phoneNumber!, url: item.url!)
                arrayOfRestaurants.append(newRestaurant)
            }
            
            completion(restaurants: arrayOfRestaurants)
        }
    
    }
 
}
