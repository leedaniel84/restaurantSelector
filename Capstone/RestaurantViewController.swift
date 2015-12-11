//
//  ViewController.swift
//  Capstone
//
//  Created by Daniel Lee on 11/16/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import UIKit
import MapKit

class RestaurantViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var restaurantList = [Restaurant]()
    
    @IBOutlet weak var restaurantPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationController.sharedInstance.getUserLocation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdatedNotification:", name: "locationUpdated", object: nil)
        
        self.navigationItem.title = "Getting Location"
    }
    
    //MARK: - PickerView Data Source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurantList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restaurantList[row].name
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
    }

}

