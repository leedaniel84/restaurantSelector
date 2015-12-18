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
    var index = 0
    
    @IBOutlet weak var restaurantPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        restaurantPickerView.dataSource = self
//        restaurantPickerView.delegate = self
//        restaurantPickerView.selectRow((maxElements / 2), inComponent: 0, animated: false)
        
        LocationController.sharedInstance.getUserLocation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdatedNotification:", name: "locationUpdated", object: nil)
        
        self.navigationItem.title = "Getting Location"
        
        self.becomeFirstResponder()
    }
    
    //MARK: - Displays User location
    func locationUpdatedNotification(notification: NSNotification) {
        if let locationInEnglish = notification.userInfo!["locationInEnglish"] as? String {
            self.navigationItem.title = "\(locationInEnglish)"
        }
        
        if let location = notification.userInfo!["location"] as? CLLocation {
            RestaurantController.getRestaurants(location, completion: { (restaurants) -> Void in
                self.restaurantList = restaurants
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.restaurantPickerView.reloadAllComponents()
                })
            })
        }
    }
    

    //MARK: - Pickerview Data Source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurantList.count
    }
    
    
    //MARK: - Pickerview Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return restaurantList[row].name
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.index = row
    }
    
 
    //MARK: - Implementing Shake functionality
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if(event!.subtype == UIEventSubtype.MotionShake) {
            
            for var randomRestaurants = restaurantList.count - 1; randomRestaurants > 0; randomRestaurants-- {
                let randomized = Int(arc4random_uniform(UInt32(randomRestaurants - 1)))
                swap(&restaurantList[randomRestaurants], &restaurantList[randomized])
            }
            
            self.restaurantPickerView.reloadAllComponents()
        }

    }

    @IBAction func seeDetailsButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("toShowDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShowDetail" {
            if let detailViewController = segue.destinationViewController as? RestaurantDetailViewController {
                _ = detailViewController.view
                
                
                detailViewController.updateWithRestaurant(restaurantList[index])
                
            }
        }
    }

}

