//
//  Weather.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/27/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation
import UIKit

class Weather {

    var tempData = [Double]()
    var cloudData = [Double]()
    var precipData = [Double]()
    
    init(URL: String) {
        let requestURL: NSURL = NSURL(string: URL)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                if let jsonData = data {
                    do {
                        let JSONResult =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                        // Looping so that we can add the information to the arrays, and get data for 7 days
                        for index in 0...6 {
                            // This guard statement checks to see if what is return is a Dictionary
                            // A guard statement removes the need to have multiple "if let" statements
                            guard let daily = JSONResult["daily"] as? [String : AnyObject],
                            // checking to see if this an array of AnyObjects
                            let dailyData = daily["data"] as? [AnyObject],
                            // checking to see if what is returned is a Dictionary
                            let dailyDataforDay = dailyData[index] as? [String: AnyObject]
                                else {
                                    print("JSON not available to be parsed.")
                                    return
                            }
                            // Adding it to the arrays
                            self.tempData.append(dailyDataforDay["apparentTemperatureMax"] as! Double!)
                            self.cloudData.append(dailyDataforDay["cloudCover"] as! Double!)
                            self.precipData.append(dailyDataforDay["precipProbability"] as! Double!)
                        }
                     }
                    catch {
                        print("Could not process the JSON.")
                    }
                }
            }
        }
        task.resume()
    }
    
    func imageForWeather(cloudCover: Double, precipPossibility: Double) -> UIImage? {
        if (precipPossibility >= 0.5) {
            return UIImage(named: "rain.png")
        }
        else if (cloudCover < 0.5) {
            return UIImage(named: "sun.png")
        }
        else if (cloudCover >=  0.5) {
            return UIImage(named: "clouds.png")
        }
        return nil
    }
    
    func wordForWeather(temp: Double) -> String? {
        if (temp < 25) {
            return "very cold"
        }
        else if (temp < 50) {
            return "cold"
        }
        else if (temp <= 80) {
            return "warm"
        }
        else {
            return "hot"
        }
    }
}

