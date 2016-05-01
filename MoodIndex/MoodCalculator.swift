//
//  MoodCalculator.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/28/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation
import UIKit


class MoodCalculator {
    
    var mood = [String : Int]()
    var baseIndex: Int = 30
    var moodPhrase: String = ""
    
    func calculateMood(date: String, precipData: Double, cloudData: Double, tempData: Double, otherFactors: [String : Int]?) -> UIImage? {
        //var rainPreference = 5
        //var cloudPreference = 5
        //var tempPreference = 5
        //if let getValue = NSUserDefaults.standardUserDefaults().objectForKey("rainPreference") {
            let rainPreference = NSUserDefaults.standardUserDefaults().integerForKey("rainPreference")
            let cloudPreference = NSUserDefaults.standardUserDefaults().integerForKey("cloudPreference")
            let tempPreference = NSUserDefaults.standardUserDefaults().integerForKey("temperaturePreference")
        //}
        
        if let otherFactorsData = otherFactors {
            let numberOfOtherFactors = otherFactorsData.count
            for _ in 0..<numberOfOtherFactors {
                baseIndex += 10
            }
        }
        
        let sections: Int = ((baseIndex * 2)/4)
        
        //Calculate Rain Data
        if (precipData > 0.5) {
            if (rainPreference < 5) {
                baseIndex = baseIndex - (10 - rainPreference)
            }
            else if (rainPreference > 5) {
                baseIndex = baseIndex + rainPreference
            }
        }
        else if (precipData < 0.5) {
            if (rainPreference < 5) {
                baseIndex = baseIndex + rainPreference
            }
            else if (rainPreference > 5) {
                baseIndex = baseIndex - (10 - rainPreference)
            }
        }
        
        // Calculate Cloud Data
        if (cloudData > 0.5) {
            if (cloudPreference < 5) {
                baseIndex = baseIndex - (10 - cloudPreference)
            }
            else if (cloudPreference > 5) {
                baseIndex = baseIndex + cloudPreference
            }
        }
        else if (cloudData < 0.5) {
            if (cloudPreference < 5) {
                baseIndex = baseIndex + cloudPreference
            }
            else if (rainPreference > 5) {
                baseIndex = baseIndex - (10 - cloudPreference)
            }
        }
        
        // Calculate Temp Data
        if (tempData > 50) {
            if (tempPreference < 5) {
                baseIndex = baseIndex - (10 - tempPreference)
            }
            else if (cloudPreference > 5) {
                baseIndex = baseIndex + tempPreference
            }
        }
        else if (tempData < 50) {
            if (tempPreference < 5) {
                baseIndex = baseIndex + tempPreference
            }
            else if (tempPreference > 5) {
                baseIndex = baseIndex - (10 - tempPreference)
            }
        }
        
        
        if let otherFactorsData = otherFactors {
            let ArrayPreferences = Array(otherFactorsData.values)
            for index in 0..<ArrayPreferences.count {
                if (ArrayPreferences[index] > 5) {
                    baseIndex = baseIndex + ArrayPreferences[index]
                }
                else {
                    baseIndex = baseIndex - (10 - ArrayPreferences[index])
                }
            }
        }
        
        
        mood[date] = baseIndex
        
        if (baseIndex <= sections) {
            moodPhrase = "very sad"
            return UIImage(named: "very-sad.png")!
        }
        else if (baseIndex < (sections*2)) {
            moodPhrase = "sad"
            return UIImage(named: "sad.png")!
        }
        else if (baseIndex == (sections*2)) {
            moodPhrase = "neutral"
            return UIImage(named: "neutral.png")!
        }
        else if (baseIndex <= (sections*3)) {
            moodPhrase = "happy"
            return UIImage(named: "happy.png")!
        }
        else {
            moodPhrase = "very happy"
            return UIImage(named: "very-happy.png")!
        }
    }
    
    func returnMood() -> [String : Int] {
        return self.mood
    }
    
}