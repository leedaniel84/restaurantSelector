//
//  RestaurantController.swift
//  Capstone
//
//  Created by Daniel Lee on 11/19/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import Foundation
import MapKit
import AddressBookUI


class RestaurantController {
    
    static let sharedController = RestaurantController()
    
    static var arrayOfRestaurants:[Restaurant] = []

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
            
            arrayOfRestaurants = []
            for item in response.mapItems {
                print(item)
//                let placemark = item.placemark.coordinate
                guard let name = item.name,
//                    let addressDictionary = item.placemark.addressDictionary,
                    let phone = item.phoneNumber,
                    let url = item.url else {
                    continue
                }
                
//                let address = ABCreateStringWithAddressDictionary(addressDictionary, false)
                
                let newRestaurant = Restaurant(name: name, phone: phone, url: url, placemark: item.placemark)
                arrayOfRestaurants.append(newRestaurant)
                
            }
            completion(restaurants: arrayOfRestaurants)
        }
    
    }
 
}
