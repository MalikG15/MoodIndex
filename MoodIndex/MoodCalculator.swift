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
    
    var baseIndex = 30
    var moodPhrase = ""
    
    // Passes in the weather information, and otherFactors maybe
    func calculateMood(precipData: Double, cloudData: Double, tempData: Double, otherFactors: [String : Int]?) -> UIImage? {
            // Retrieving the saved preferences, and when data is saved as integers or doubles, there
            // default values is zero
            let rainPreference = NSUserDefaults.standardUserDefaults().integerForKey("rainPreference")
            let cloudPreference = NSUserDefaults.standardUserDefaults().integerForKey("cloudPreference")
            let tempPreference = NSUserDefaults.standardUserDefaults().integerForKey("temperaturePreference")
        
        // if otherFactors is equal to null then
        // we increase the baseIndex
        if let otherFactorsData = otherFactors {
            let numberOfOtherFactors = otherFactorsData.count
            for _ in 0..<numberOfOtherFactors {
                baseIndex += 10
            }
        }
        
        // Multiply by 2 and divide by 4 to get 
        // 4 distinct sections that a mood can be
        // placed in
        // 0 - 15 - very sad
        // 16 - 30 - sad
        // 30 - neutral
        // 30 - 45 - happy
        // 45 - 60 - very happy
        let sections: Int = ((baseIndex * 2)/4)
        
        //Calculate Rain Data
        if (precipData > 0.5) {
            // If there is a high probability that
            // it will rain the baseIndex changes based on 
            // your set preference
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
            // If there will be a lot of clouds in the sky that
            // the baseIndex changes based on
            // your set preference
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
            // If the temp is high            
            // the baseIndex changes based on
            // your set preference
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
        
        // If otherfactors exist then we change baseIndex based on that
        // the preferences has to be greater than 5 to positively affect 
        // mood.
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
        
        // Based on what quadrant baseIndex is placed in
        // We can return the appropiate image 
        // and get the right phrase
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
    
}