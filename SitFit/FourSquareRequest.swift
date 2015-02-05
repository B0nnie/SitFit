//
//  FourSquareRequest.swift
//  Maps
//
//  Created by Ebony Nyenya on 2/2/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit
import  CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "W0FPIEJRFJO1TEVQPZYKGAQ4GXN5EMQPXLHRYDXJD20TENQR"
let CLIENT_SECRET = "D3NV5GCZSMLHXJJDKDESPDJARTMRTO5FC1JI34LWLVMAVADO"

class FourSquareRequest: NSObject {
   
    class func requestVenuesWithLocation (location: CLLocation) -> [AnyObject] {
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        println(requestString)

        
        if let url = NSURL (string: requestString) {
            
            let request = NSURLRequest(URL: url)
            
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String: AnyObject] {
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    
                    let venues = responseInfo["venues"] as [AnyObject]
                    
                    return venues
                    
                }
                
                
            }
            
            
        }
        
        
        // TODO: add implementation to return venues
        
        return []
        
    }
    
    
}
