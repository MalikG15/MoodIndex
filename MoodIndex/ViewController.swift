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
    
    let locationManager = CLLocationManager()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MoodCell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodCell", forIndexPath: indexPath)
        
        var next7DaysDates = [String]()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        var numDay:Double = 24.0
        for _ in 0...6 {
            var tableDate = ""
            let moveDate = date.dateByAddingTimeInterval(60*60*numDay)
            tableDate += String(calendar.component([.Month], fromDate: moveDate)) + " - "
            tableDate += String(calendar.component([.Day], fromDate: moveDate)) + " - "
            tableDate += String(calendar.component([.Year], fromDate: moveDate))
            next7DaysDates.append(tableDate)
            numDay = numDay + 24
        }
 
        cell.detailTextLabel?.text = next7DaysDates[indexPath.row]
        //cell.detailTextLabel?.text = "hello"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        //self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (long == 0.0 && lat == 0.0) {
            var userLocation:CLLocation = locations[0] as! CLLocation
            long = userLocation.coordinate.longitude;
            lat = userLocation.coordinate.latitude;
            print("locations = \(long) and \(lat)")
            let weather = Weather(URL: "https://api.forecast.io/forecast/8fdc70a7aade55aadd377e9c1f9bc2c4/37.8267,-122.423")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
