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
    
    /*@IBAction func getLocationConfirmation(sender: UIButton) {
        let alert = UIAlertController(title: "Location Permission", message: "This app needs your permission to access your location")
        
        
    
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
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
        var userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        print("locations = \(long) and \(lat)")
        /*let location:CLLocation = locations[locations.count-1] as! CLLocation
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            print(location.coordinate, terminator: "")
            //updateWeatherInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
        }*/
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
