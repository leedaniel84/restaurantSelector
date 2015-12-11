//
//  Restaurants.swift
//  Capstone
//
//  Created by Daniel Lee on 11/16/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Restaurant {
    var name: String
    var phone: String
    var coordinates: CLLocation?
    var url: NSURL?
    var placemark: MKPlacemark
    
    init(name: String, placemark: MKPlacemark, phone: String, url: NSURL) {

        
        self.name = name
        self.phone = phone
        self.placemark = placemark
        self.url = url
        self.coordinates = placemark.location
    }
    
}

