//
//  MoreVariablesController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/29/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation
import UIKit

class MoreVariablesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Received from ViewController
    var selectedCell: UITableViewCell?
    var date: String?
    
    var events: [String : Int] = [:]
    
    var selectedCellImageWeather: UIImageView?
    
    var selectedCellMoodImage: UIImageView?
    
    var selectedCellWeatherDescription: UILabel?
    
    var selectedCellMoodDescription: UILabel?
    
    @IBOutlet weak var variableName: UITextField!
        
    @IBOutlet weak var variableRating: UISlider!
    
    @IBOutlet weak var eventTable: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("variableCell", forIndexPath: indexPath)
        
        if let events = NSUserDefaults.standardUserDefaults().objectForKey(self.date!) as? NSData {
            if let eventData = NSKeyedUnarchiver.unarchiveObjectWithData(events) as? Dictionary<String, Int> {
                    var rowLevel = 0
                    var labelText = ""
                    for index in eventData.keys {
                        if (rowLevel == indexPath.row) {
                            labelText = index
                            break
                        }
                        rowLevel += 1
                    }
                    if let nameOfEvent = cell.viewWithTag(100) as? UILabel {
                        nameOfEvent.text = labelText
                    }
                    if let ratingOfEvent = cell.viewWithTag(101) as? UILabel {
                        if let _: Int = eventData[labelText] {
                            ratingOfEvent.text = String(eventData[labelText]!)
                        }
                        else {
                            ratingOfEvent.text = ""
                        }
                    }
                }
        }
        return cell
    }

    
    @IBAction func submitEvent(sender: AnyObject) {
        if (variableName.text! == "") {

            let alert = UIAlertController(title: "Input Error", message: "You need to type an event name to submit it.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                // Doing nothing here since I just want to warn users
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        else if ((variableName.text!).characters.count > 35) {
            
            let alert = UIAlertController(title: "Input Error", message: "Your input is too long, please shorten it to submit it.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                // Doing nothing here since I just want to warn users
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let nameOfEvent: String = variableName.text!
        let ratingOfEvent: Int = Int(variableRating.value)
    
        
        events[nameOfEvent] = ratingOfEvent
        
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(events), forKey: date!)
        if let table = eventTable {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                table.reloadData()
            })
        }
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
    
    
    // SelectedCell still has it's contents in viewDidLoad()
    // Grabbing content through it's tags
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let events = NSUserDefaults.standardUserDefaults().objectForKey(date!) as? NSData {
            if let eventData = NSKeyedUnarchiver.unarchiveObjectWithData(events) as? Dictionary<String, Int> {
                self.events = eventData
            }
        }
        
        self.eventTable.delegate = self
        self.eventTable.dataSource = self
        
        // Checking to see if selectedCell has a value
        if let passedCell = selectedCell {
            selectedCellImageWeather = passedCell.viewWithTag(100) as? UIImageView
            selectedCellWeatherDescription = passedCell.viewWithTag(101) as? UILabel
            selectedCellMoodImage = passedCell.viewWithTag(102) as? UIImageView
            selectedCellMoodDescription = passedCell.viewWithTag(103) as? UILabel
        }
        
        // Looks for single or multiple taps.
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
