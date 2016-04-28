//
//  Weather.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/27/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation

class Weather {
    var weather: String = ""
    
    init(URL: String) {
        let requestURL: NSURL = NSURL(string: URL)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
            }
        }
        task.resume()
        
    }
}

