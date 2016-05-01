//
//  PreferencesController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/28/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation
import UIKit

class PreferencesController: UIViewController {
    
    var rainPreferenceValue: Int?
    var cloudPreferenceValue: Int?
    var temperaturePreferenceValue: Int?
    
    @IBOutlet weak var rainPreference: UISlider!
    
    @IBOutlet weak var cloudPreference: UISlider!
    
    @IBOutlet weak var temperaturePreference: UISlider!
    
    
    @IBAction func updateIndex(sender: AnyObject) {
        // Getting the values from the sliders
        rainPreferenceValue = Int(rainPreference.value)
        cloudPreferenceValue = Int(cloudPreference.value)
        temperaturePreferenceValue = Int(temperaturePreference.value)
        // Saving the data as an integer and a unique key
        NSUserDefaults.standardUserDefaults().setInteger(rainPreferenceValue!, forKey: "rainPreference")
        NSUserDefaults.standardUserDefaults().setInteger(cloudPreferenceValue!, forKey: "cloudPreference")
        NSUserDefaults.standardUserDefaults().setInteger(temperaturePreferenceValue!, forKey: "temperaturePreference")
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "preferencesNotSet")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the saved values
        rainPreference.value = NSUserDefaults.standardUserDefaults().floatForKey("rainPreference")
        cloudPreference.value = NSUserDefaults.standardUserDefaults().floatForKey("cloudPreference")
        temperaturePreference.value = NSUserDefaults.standardUserDefaults().floatForKey("temperaturePreference")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}