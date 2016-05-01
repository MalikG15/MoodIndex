//
//  ViewController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/23/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var moodTable: UITableView!

    var lat: CLLocationDegrees = 0.0
    var long: CLLocationDegrees = 0.0
    
    var weather: Weather?
    var calculator: MoodCalculator = MoodCalculator()
    
    // necessary to get the location of the user
    let locationManager = CLLocationManager()
    
    var selectedRow: UITableViewCell?
    
    var chosenDate: String = ""
    var dateArray = [String]()
    
    var otherFactors: [String : Int]?
    
    // viewWillAppear and viewDidAppear occur before viewDidLoad
    // Runs the function before the view appears
    override func viewWillAppear(animated: Bool) {
        // Get's user defaults and places it inside a variable
        let preferences: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // By default the object will be set to true, even though it doesnt exist when
        // app first loads up
        let isPreferencesNotSet = preferences.objectForKey("preferencesNotSet") as? Bool
            // If equal to true we hide the view
            if (isPreferencesNotSet != false) {
                self.view.hidden = true
            // else we don't hide the view
            } else {
                self.view.hidden = false
            }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let isPreferencesNotSet = prefs.objectForKey("preferencesNotSet") as? Bool
        // if the preferences are not set the we perform the segue
        if (isPreferencesNotSet != false) {
            self.performSegueWithIdentifier("setPreferences", sender: self)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Declaring the number of rows in the table
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Take off a cell that exists, which is a prototype cell with a specific identifier
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodCell", forIndexPath: indexPath)
        
        // Establishing a NSDate() to calculate the next 7 days
        // This code is ran through for each cell so no need for a loop
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let numDay:Double = 24.0 * Double(indexPath.row)
            var tableDate = ""
            let moveDate = date.dateByAddingTimeInterval(60*60*numDay)
            tableDate += String(calendar.component([.Month], fromDate: moveDate)) + "-"
            tableDate += String(calendar.component([.Day], fromDate: moveDate)) + "-"
            tableDate += String(calendar.component([.Year], fromDate: moveDate))
        
        // Retreiving the data for a specific date, which contains events for that date
        if let events = NSUserDefaults.standardUserDefaults().objectForKey(tableDate) as? NSData {
            if let eventData = NSKeyedUnarchiver.unarchiveObjectWithData(events) as? Dictionary<String, Int> {
                otherFactors = eventData
            }
        }
        else {
            // We only want otherFactors to have data for a specific date
            // so it is set to nil if a there is no data for that specific
            // date
            otherFactors = nil
        }
        // Add the tableDate to the dateArray so that it can be passed to MoreVariablesController
        // and it corresponds with table cells
        dateArray.append(tableDate)
        // if weather doesn't have any data, then we reload the table
        if let weatherData = self.weather {
            // we have to wait for the array to have 7, then we know that we can load the table
            if (weatherData.cloudData.count == 7) {
                // Adding data for a specific row by getting views with a tag
                if let imageForWeather = cell.viewWithTag(100) as? UIImageView {
                    imageForWeather.image = weatherData.imageForWeather(weatherData.cloudData[indexPath.row], precipPossibility:weatherData.precipData[indexPath.row])
                }
                if let weatherDescription = cell.viewWithTag(101) as? UILabel {
                    weatherDescription.text = "The temperature is going to be \(weatherData.wordForWeather(weatherData.tempData[indexPath.row])!)"
                }
                if let moodPicture = cell.viewWithTag(102) as? UIImageView {
                    moodPicture.image = calculator.calculateMood(weatherData.precipData[indexPath.row], cloudData: weatherData.cloudData[indexPath.row], tempData: weatherData.tempData[indexPath.row], otherFactors: otherFactors)
                }
                if let moodDescription = cell.viewWithTag(103) as? UILabel {
                    moodDescription.text = "Your mood on \(tableDate) is \(calculator.moodPhrase)"
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    tableView.reloadData()
                })
            }
            
        }
        else {
            //self.performSegueWithIdentifier("setPreferences", sender: self)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                tableView.reloadData()
            })
        }

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        // Once location is enabled we can access the information
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        // Get the view to recognize the table
        self.moodTable.delegate = self
        self.moodTable.dataSource = self
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // Locations is an array and the first item contains longitude and latitude information
            let userLocation:CLLocation = locations[0]
            long = userLocation.coordinate.longitude
            lat = userLocation.coordinate.latitude
            weather = Weather(URL: "https://api.forecast.io/forecast/8fdc70a7aade55aadd377e9c1f9bc2c4/\(lat),\(long)")
    }
    
    // Works in tandem with the prepareForSeque to get the table row that was selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Getting the cell that was selected
        selectedRow = tableView.cellForRowAtIndexPath(indexPath)
        // The date array has the dates in order of the cells, and I am retreving the date for that row
        chosenDate = dateArray[indexPath.row]
        //Executes the segue and sends the neccesary identifier to prepareForSegue
        self.performSegueWithIdentifier("MoreVariables", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject!) {
        if (segue!.identifier == "MoreVariables") {
            // Associating the segue with the MoreVariablesController
            let addMoreVariablesController = segue!.destinationViewController as! MoreVariablesController
            
            // Passing the information to the member variables in the controller above
            addMoreVariablesController.selectedCell = selectedRow
            addMoreVariablesController.date = chosenDate
        }
        //else if (segue!.identifier == "setPreferences") {
            
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
