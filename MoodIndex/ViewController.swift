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
    
    let locationManager = CLLocationManager()
    
    var selectedRow: UITableViewCell?
    
    var chosenDate: String = ""
    var dateArray = [String]()
    
    var otherFactors: [String : Int]?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodCell", forIndexPath: indexPath)
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let numDay:Double = 24.0 * Double(indexPath.row)
            var tableDate = ""
            let moveDate = date.dateByAddingTimeInterval(60*60*numDay)
            tableDate += String(calendar.component([.Month], fromDate: moveDate)) + "-"
            tableDate += String(calendar.component([.Day], fromDate: moveDate)) + "-"
            tableDate += String(calendar.component([.Year], fromDate: moveDate))
        
        
        if let events = NSUserDefaults.standardUserDefaults().objectForKey(tableDate) as? NSData {
            if let eventData = NSKeyedUnarchiver.unarchiveObjectWithData(events) as? Dictionary<String, Int> {
                otherFactors = eventData
            }
        }
        else {
            otherFactors = nil
        }
        
        dateArray.append(tableDate)
        if let weatherData = self.weather {
            if (weatherData.cloudData.count == 7) {
                if let imageForWeather = cell.viewWithTag(100) as? UIImageView {
                    imageForWeather.image = weatherData.imageForWeather(weatherData.cloudData[indexPath.row], precipPossibility:weatherData.precipData[indexPath.row])
                }
                if let weatherDescription = cell.viewWithTag(101) as? UILabel {
                    weatherDescription.text = "The temperature is going to be \(weatherData.wordForWeather(weatherData.tempData[indexPath.row])!)"
                }
                if let moodPicture = cell.viewWithTag(102) as? UIImageView {
                    moodPicture.image = calculator.calculateMood(tableDate, precipData: weatherData.precipData[indexPath.row], cloudData: weatherData.cloudData[indexPath.row], tempData: weatherData.tempData[indexPath.row], otherFactors: otherFactors)
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
        //self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        self.moodTable.delegate = self
        self.moodTable.dataSource = self
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (long == 0.0 && lat == 0.0) {
            let userLocation:CLLocation = locations[0]
            long = userLocation.coordinate.longitude;
            lat = userLocation.coordinate.latitude;
            print("locations = \(long) and \(lat)")
            weather = Weather(URL: "https://api.forecast.io/forecast/8fdc70a7aade55aadd377e9c1f9bc2c4/\(lat),\(long)")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = tableView.cellForRowAtIndexPath(indexPath)
        chosenDate = dateArray[indexPath.row]
        //Executes the segue and sends the neccesary identifier to prepareForSegue
        self.performSegueWithIdentifier("MoreVariables", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject!) {
        if (segue!.identifier == "MoreVariables") {
            let addMoreVariablesController = segue!.destinationViewController as! MoreVariablesController
            //let selectedCell = tableView.indexPathForSelectedRow()
            addMoreVariablesController.selectedCell = selectedRow
            addMoreVariablesController.date = chosenDate
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
