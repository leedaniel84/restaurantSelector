//
//  LocationController.swift
//  Capstone
//
//  Created by Daniel Lee on 11/20/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import UIKit
import CoreLocation


class LocationController: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationController()
    
    private var locationManager = CLLocationManager()
    
    func getUserLocation() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            addressOfLocation(location, completion: { (locationInEnglish) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("locationUpdated", object: nil, userInfo: ["location": location, "locationInEnglish": locationInEnglish])
            })
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error Getting Location")
    }
    
    func addressOfLocation(location: CLLocation, completion:(locationInEnglish: String) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemark, error) -> Void in
            if let name = placemark![0].name {
                completion(locationInEnglish: name)
                
            }
            
        }
        
    }
    
}