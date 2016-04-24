//
//  ViewController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/23/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    //@IBOutlet weak var moodTable: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        /*let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        var numDay:Double = 24.0
        for _ in 0...6 {
            let moveDate = date.dateByAddingTimeInterval(60*60*numDay)
            cell.textLabel?.text = String(calendar.component([.Day], fromDate: moveDate))
            numDay = numDay + 24
        }*/
        
        cell.textLabel?.text = "Hey Bud"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Iterate over the array and get each day
        // and then add it to the table
        // Do any additional setup after loading the view, typically from a nib.
        /*let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day], fromDate: date)
        var num = 24;
        let date_1 = date.dateByAddingTimeInterval(60*60*24)
        print(calendar.component([.Day], fromDate: date_1))*/
        
        /*for num in 0...6 {
            moodTable.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>)
        }*/
 }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
