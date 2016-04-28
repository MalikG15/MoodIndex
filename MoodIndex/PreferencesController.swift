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

    @IBOutlet weak var cloudPreferences: UISlider!
    
    
    @IBOutlet weak var temperaturePreference: UISlider!
    
    
    @IBAction func preferencesSubmit(sender: AnyObject) {
        rainPreferenceValue = Int(rainPreference.value)
        cloudPreferenceValue = Int(cloudPreferences.value)
        temperaturePreferenceValue = Int(temperaturePreference.value)
        NSUserDefaults.standardUserDefaults().setObject(rainPreferenceValue, forKey: "rainPreference")
        NSUserDefaults.standardUserDefaults().setObject(cloudPreferenceValue, forKey: "cloudPreference")
        NSUserDefaults.standardUserDefaults().setObject(temperaturePreferenceValue, forKey: "temperaturePreference")
        let ViewController1: ViewController = ViewController()
        self.presentViewController(ViewController1, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}