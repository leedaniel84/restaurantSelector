//
//  RestaurantDetailViewController.swift
//  Capstone
//
//  Created by Daniel Lee on 11/16/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var restaurantMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    var selectedRestaurant = Restaurant(name: "", phone: "", url: NSURL(string: "http://www.google.com")!, placemark:  )
    
    func updateWithRestaurant(restaurant: Restaurant) {
        selectedRestaurant = restaurant
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath)
        
        if indexPath.row == 0{
            cell.textLabel?.text = selectedRestaurant.phone
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "\(selectedRestaurant.placemark)"
        } else {
            cell.textLabel?.text = "\(selectedRestaurant.url!)"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

extension RestaurantDetailViewController: MKMapViewDelegate {
        
        
        
}




