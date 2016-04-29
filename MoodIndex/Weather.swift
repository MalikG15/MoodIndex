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
    //var weather: String = ""
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
                        for index in 0...6 {
                            guard let daily = JSONResult["daily"] as? [String : AnyObject],
                            let dailyData = daily["data"] as? [AnyObject],
                            let dailyDataforDay = dailyData[index] as? [String: AnyObject]
                                else {
                                    print("JSON not available to be parsed.")
                                    return
                            }
                            //print(String(dailyDataforDay["precipProbability"]!))
                            //print(String(dailyDataforDay["cloudCover"]!))
                            //print(String(dailyDataforDay["apparentTemperatureMax"]!))
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
        //else {
          //  print("There is something wrong with the internet connection")
        //}
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
            return UIImage(named: "bad-weather.png")
        }
        return nil
    }
    
    func wordForWeather(temp: Double) -> String? {
        if (temp < 25) {
            return "Very Cold"
        }
        else if (temp < 50) {
            return "Cold"
        }
        else if (temp <= 80) {
            return "Warm"
        }
        else {
            return "Hot"
        }
    }
}

