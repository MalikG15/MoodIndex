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

    /*init(precipPreference: Int, cloudPreference: Int, tempPreference: Int, otherFactors: [String : Int]?) {
       //if ()
    }*/
    
    //init() {
        
    //}
    
    func calculateMood(date: String, precipData: Double, cloudData: Double, tempData: Double, otherFactors: [String : Int]?) -> UIImage? {
        let rainPreference = Int(NSUserDefaults.standardUserDefaults().objectForKey("rainPreference") as! NSNumber!)
        let cloudPreference: Int = Int(NSUserDefaults.standardUserDefaults().objectForKey("cloudPreference") as! NSNumber!)
        let tempPreference = Int(NSUserDefaults.standardUserDefaults().objectForKey("temperaturePreference") as! NSNumber!)
        
        if let otherFactorsData = otherFactors {
            let numberOfOtherFactors = otherFactorsData.count
            for _ in 0..<numberOfOtherFactors {
                baseIndex += 10
            }
        }
        
        let sections = (baseIndex/4)
        
        //Calculate Rain Data
        if (precipData > 0.5) {
            if (rainPreference < 5) {
                baseIndex - (10 - rainPreference)
            }
            else if (rainPreference > 5) {
                baseIndex + rainPreference
            }
        }
        else if (precipData < 0.5) {
            if (rainPreference < 5) {
                baseIndex + rainPreference
            }
            else if (rainPreference > 5) {
                baseIndex - (10 - rainPreference)
            }
        }
        
        // Calculate Cloud Data
        if (cloudData > 0.5) {
            if (cloudPreference < 5) {
                baseIndex - (10 - cloudPreference)
            }
            else if (cloudPreference > 5) {
                baseIndex + cloudPreference
            }
        }
        else if (cloudData < 0.5) {
            if (cloudPreference < 5) {
                baseIndex + cloudPreference
            }
            else if (rainPreference > 5) {
                baseIndex - (10 - cloudPreference)
            }
        }
        
        // Calculate Temp Data
        if (tempData > 50) {
            if (tempPreference < 5) {
                baseIndex - (10 - tempPreference)
            }
            else if (cloudPreference > 5) {
                baseIndex + tempPreference
            }
        }
        else if (tempData < 50) {
            if (tempPreference < 5) {
                baseIndex + tempPreference
            }
            else if (tempPreference > 5) {
                baseIndex - (10 - tempPreference)
            }
        }
        
        if let otherFactorsData = otherFactors {
            let ArrayPreferences = Array(otherFactorsData.values)
            for index in 0..<ArrayPreferences.count {
                if (ArrayPreferences[index] > 5) {
                    baseIndex + ArrayPreferences[index]
                }
                else {
                    baseIndex - ArrayPreferences[index]
                }
            }
        }
        
        mood[date] = baseIndex
        
        if (baseIndex <= sections) {
            return UIImage(named: "very_sad.jpg")!
        }
        else if (baseIndex < (sections*2)) {
            return UIImage(named: "sad.jpg")!
        }
        else if (baseIndex == (sections*2)) {
            return UIImage(named: "neutral.jpg")!
        }
        else if (baseIndex <= (sections*3)) {
            return UIImage(named: "happy.jpg")!
        }
        else {
            return UIImage(named: "very_happy.jpg")!
        }
    
    }
    
    func returnMood() -> [String : Int] {
        return self.mood
    }
    
    func checkIndexNegative(index: Int) {
        if (index < 0) {
            self.baseIndex = 0
        }
    }
}