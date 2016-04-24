//
//  ViewController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/23/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moodTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
