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

class ViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var moodTable: UITableView!

    var lat: CLLocationDegrees = 0.0
    var long: CLLocationDegrees = 0.0
    
    var weather: Weather?
    var calculator: MoodCalculator = MoodCalculator()
    
    let locationManager = CLLocationManager()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MoodCell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodCell", forIndexPath: indexPath)
        
        //var next7DaysDates = [String]()
        
        //var calculator: MoodCalculator = MoodCalculator()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        var numDay:Double = 24.0 * Double(indexPath.row)
        //for _ in 0...6 {
            var tableDate = ""
            let moveDate = date.dateByAddingTimeInterval(60*60*numDay)
            tableDate += String(calendar.component([.Month], fromDate: moveDate)) + "-"
            tableDate += String(calendar.component([.Day], fromDate: moveDate)) + "-"
            tableDate += String(calendar.component([.Year], fromDate: moveDate))
            //next7DaysDates.append(tableDate)
       // }
        if let weatherData = self.weather {
            if (weatherData.cloudData.count == 7) {
                if let imageForWeather = cell.viewWithTag(100) as? UIImageView {
                    imageForWeather.image = weatherData.imageForWeather(weatherData.cloudData[indexPath.row], precipPossibility:weatherData.precipData[indexPath.row])
                }
                if let weatherDescription = cell.viewWithTag(101) as? UILabel {
                    weatherDescription.text = "The temperature is going to be \(weatherData.wordForWeather(weatherData.tempData[indexPath.row])!)"
                }
                if let moodPicture = cell.viewWithTag(102) as? UIImageView {
                    moodPicture.image = calculator.calculateMood(tableDate, precipData: weatherData.precipData[indexPath.row], cloudData: weatherData.cloudData[indexPath.row], tempData: weatherData.tempData[indexPath.row], otherFactors: nil)
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
        
 
        //cell.detailTextLabel?.text = next7DaysDates[indexPath.row]
        //cell.detailTextLabel?.text = "hello"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let temperaturePreference = NSUserDefaults.standardUserDefaults().objectForKey("temperaturePreference")
        
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
