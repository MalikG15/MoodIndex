//
//  ViewController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/23/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var moodTable: UITableView!
    
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
 }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
