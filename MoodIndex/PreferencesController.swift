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
    
    
    /*@IBAction func saveChangedValue(sender: UISlider) {
        
    }*/
    
    @IBAction func Changes(sender: UISlider) {
        NSUserDefaults.standardUserDefaults().setFloat(sender.value, forKey: "sliderValueRain")
    }
    
    @IBAction func updateIndex(sender: AnyObject) {
        rainPreferenceValue = Int(rainPreference.value)
        cloudPreferenceValue = Int(cloudPreference.value)
        temperaturePreferenceValue = Int(temperaturePreference.value)
        NSUserDefaults.standardUserDefaults().setInteger(rainPreferenceValue!, forKey: "rainPreference")
        NSUserDefaults.standardUserDefaults().setInteger(cloudPreferenceValue!, forKey: "cloudPreference")
        NSUserDefaults.standardUserDefaults().setInteger(temperaturePreferenceValue!, forKey: "temperaturePreference")
        //let ViewController1: ViewController = ViewController()
        //self.presentViewController(ViewController1, animated: true, completion: nil)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        rainPreference.value = NSUserDefaults.standardUserDefaults().floatForKey("rainPreference")
        cloudPreference.value = NSUserDefaults.standardUserDefaults().floatForKey("cloudPreference")
        temperaturePreference.value = NSUserDefaults.standardUserDefaults().floatForKey("temperaturePreference")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}