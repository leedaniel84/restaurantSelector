//
//  YelpClient.swift
//  Capstone
//
//  Created by Daniel Lee on 12/3/15.
//  Copyright © 2015 Daniel Lee. All rights reserved.
//

import Foundation
import UIKit

let yelpConsumerKey = "gAzs8QY2Fof3UG2whwNBDw"
let yelpConsumerSecret = "j-TFWYa4YaFJt1ZGx6u0jT3Qjq8"
let yelpToken = "7pUalxQBXrc2mMmKax7VZwg-wJBFsMsH"
let yelpTokenSecret = "XoqFa-nwL6Mh6sg0ZWto5omlXgu"

enum YelpSortMode: Int {
    case Bestmatched = 0, Distance, HighestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var acccessSecret: String!
//    
//    class var sharedInstance: YelpClient! {
//        struct Static {
//            static var token: dispatch_once_t = 0
//            static var instance: YelpClient? = nil
//        }
//        
//        dispatch_once(&Static.token) {
//            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret = yelpConsumerSecret, accessToken = yelpToken, accessTokenSecret = yelpTokenSecret)
//        }
//        
//        return Static.instance!
//    }
    required init ?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String!, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(term, sort: nil, radius_filter: nil, completion: completion)
    }
    
    func searchWithTerm(term: String, sort: YelpSortMode?, radius_filter: Int = 8000, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        
        var parameters: [String: AnyObject]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue
        }
        
        if radius_filter != nil {
            parameters["radius_filter"] = 8000
        }
        print(parameters)
    
    return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
    let dictionaries = response["businesses"] as? [NSDictionary]
        if dictionaries != nil {
            completion(Business.businesses(array: dictionaries!), nil)
        }
        }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            completion(nil, error)
    
        }!)
        }
}
