//
//  Weather.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/27/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation

class Weather {
    //var weather: String = ""
    var tempData = [AnyObject]()
    var cloudData = [AnyObject]()
    var precipData = [AnyObject]()
    
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
                            //print(dailyDataforDay["precipProbability"]!)
                            self.tempData.append(dailyDataforDay["apparentTemperatureMax"]!)
                            self.cloudData.append(dailyDataforDay["cloudCover"]!)
                            self.precipData.append(dailyDataforDay["precipProbability"]!)
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
}
