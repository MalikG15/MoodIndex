//
//  MoreVariablesController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/29/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation
import UIKit

class MoreVariablesController: UIViewController, UITableViewDelegate {
    
    var selectedCell: UITableViewCell?
    
    var selectedCellImageWeather: UIImageView?
    
    var selectedCellMoodImage: UIImageView?
    
    var selectedCellWeatherDescription: UILabel?
    
    var selectedCellMoodDescription: UILabel?
    
    var UIView: UIViewController = UIViewController()

    @IBOutlet weak var variableName: UITextField!
    
    
    @IBOutlet weak var variableRating: UISlider!
    
    
    @IBAction func submitVariable(sender: AnyObject) {
        
    }
    
    // This code must be run in viewDidLayoutSubviews because the subviews aren't loaded in ViewDidLoad
    override func viewDidLayoutSubviews() {
        // A controller knows which view it is responsible for based on "self.view"
        // Connection is made through listing a class with a controller
        
            // Framing each image and label within the controller and then
            // adding it as a subView
            let weatherImage: UIImageView = selectedCellImageWeather!
            weatherImage.frame = CGRect(x: 0, y: 64, width: 135, height: 109)
            self.view.addSubview(weatherImage)
        
            let moodImage: UIImageView = selectedCellMoodImage!
            moodImage.frame = CGRect(x: 225, y: 64, width: 135, height: 109)
            self.view.addSubview(moodImage)
        
            let weatherLabel: UILabel = selectedCellWeatherDescription!
            weatherLabel.frame = CGRect(x: 0, y: 166, width: 167, height: 46)
            self.view.addSubview(weatherLabel)
        
            let moodDescription: UILabel = selectedCellMoodDescription!
            moodDescription.frame = CGRect(x: 208, y: 166, width: 167, height: 46)
            self.view.addSubview(moodDescription)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    //func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    //}
    
    // SelectedCell still has it's contents in viewDidLoad()
    // Grabbing content through it's tags
    override func viewDidLoad() {
        super.viewDidLoad()
        // Checking to see if selectedCell has a value
        if let passedCell = selectedCell {
            selectedCellImageWeather = passedCell.viewWithTag(100) as? UIImageView
            selectedCellWeatherDescription = passedCell.viewWithTag(101) as? UILabel
            selectedCellMoodImage = passedCell.viewWithTag(102) as? UIImageView
            selectedCellMoodDescription = passedCell.viewWithTag(103) as? UILabel
        }
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
