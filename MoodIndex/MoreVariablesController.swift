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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("variableCell", forIndexPath: indexPath)
        
        //let events = NSUserDefaults.standardUserDefaults().dictionaryForKey(self.date!)!
        
        if let events = NSUserDefaults.standardUserDefaults().objectForKey(self.date!) as? NSData {
            if let eventData = NSKeyedUnarchiver.unarchiveObjectWithData(events) as? Dictionary<String, Int> {
                if (eventData.count < 5) {
                    var rowLevel = 0
                    var labelText = ""
                    for index in eventData.keys {
                        if (rowLevel == indexPath.row) {
                            labelText = index
                            break;
                        }
                        rowLevel += 1
                    }
                    if let nameOfEvent = cell.viewWithTag(100) as? UILabel {
                        nameOfEvent.text = labelText
                    }
                    if let ratingOfEvent = cell.viewWithTag(101) as? UILabel {
                        if let ratingData: Int = eventData[labelText] {
                            ratingOfEvent.text = String(eventData[labelText]!)
                        }
                        else {
                            ratingOfEvent.text = ""
                        }
                    }
                }
            }
            else {
                // alert the event limit for this day as been reached
                print("You have reached the event limit for this day")
            }
        }
        /*else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                tableView.reloadData()
            })
            print("reloading")
        }*/
        return cell
    }

    
    @IBAction func submitEvent(sender: AnyObject) {
        if (variableName.text! == "") {
            // alert you must put an event name!
            print("You need to type an event name")
            return;
        }
        else if ((variableName.text!).characters.count > 16) {
            // alert you must put an event name!
            print("Your event name is too long")
            return;
        }
        
        let nameOfEvent: String = variableName.text!
        let ratingOfEvent: Int = Int(variableRating.value)
        
        print(ratingOfEvent)
        
        events[nameOfEvent] = ratingOfEvent
        
        //NSUserDefaults.standardUserDefaults().setObject(events, forKey: date!)
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
