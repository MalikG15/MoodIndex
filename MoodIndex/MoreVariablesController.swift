//
//  MoreVariablesController.swift
//  MoodIndex
//
//  Created by Malik Graham on 4/29/16.
//  Copyright © 2016 Malik Graham. All rights reserved.
//

import Foundation
import UIKit

class MoreVariablesController: UIViewController, UITableViewDelegate {
    
    var selectedCell: UITableViewCell?
    
    var selectedCellImageWeather: UIImageView?
    
    var selectedCellMoodImage: UIImageView?
    
    var selectedCellWeatherDescription: UILabel?
    
    var selectedCellMoodDescription: UILabel?
    
    var UIView: UIViewController = UIViewController()

    @IBOutlet weak var variableName: UITextField!
    
    
    @IBOutlet weak var variableRating: UISlider!
    
    
    @IBAction func submitVariable(sender: AnyObject) {
        
    }
    
    // This code must be run in viewDidLayoutSubviews because the subviews aren't loaded in ViewDidLoad
    override func viewDidLayoutSubviews() {
        // A controller knows which view it is responsible for based on "self.view"
        //let fm: CGRect = UIScreen.mainScreen().bounds
        /*if (selectedCell) != nil {
            if var weatherImage = self.view.viewWithTag(100) as? UIImageView {
                weatherImage = selectedCellImageWeather!
                weatherImage.frame = CGRect(x: 0, y: 64, width: 177, height: 128)
                self.view.addSubview(weatherImage)
            }
            if var moodImage = self.view.viewWithTag(101) as? UIImageView {
                moodImage = selectedCellMoodImage!
                moodImage.frame = CGRect(x: 198, y: 64, width: 177, height: 128)
                self.view.addSubview(moodImage)
             }
            if var weatherLabel = self.view.viewWithTag(102) as? UILabel {
                weatherLabel = selectedCellWeatherDescription!
                weatherLabel.frame = CGRect(x: 5, y: 192, width: 167, height: 4)
                //(self.view.viewWithTag(102)!).removeFromSuperview()
                self.view.addSubview(weatherLabel)
            }
            if var moodDescription = self.view.viewWithTag(103) as? UILabel {
                moodDescription = selectedCellMoodDescription!
                moodDescription.frame = CGRect(x: 203, y: 192, width: 167, height: 4)
               // moodDescription.text = selectedCellMoodDescription!.text
                //self.view.willRemoveSubview(self.view.viewWithTag(103)!)
                
                self.view.addSubview(moodDescription)
                (self.view.viewWithTag(103)!).removeFromSuperview()
            }*/
        
            let weatherImage: UIImageView = selectedCellImageWeather!
            weatherImage.frame = CGRect(x: 0, y: 64, width: 150, height: 118)
            self.view.addSubview(weatherImage)
        
            let moodImage: UIImageView = selectedCellMoodImage!
            moodImage.frame = CGRect(x: 225, y: 64, width: 150, height: 118)
            self.view.addSubview(moodImage)
        
            let weatherLabel: UILabel = selectedCellWeatherDescription!
            weatherLabel.font.fontWithSize(60)
            weatherLabel.frame = CGRect(x: 5, y: 170, width: 167, height: 100)
            self.view.addSubview(weatherLabel)
        
            let moodDescription: UILabel = selectedCellMoodDescription!
            moodDescription.frame = CGRect(x: 203, y: 170, width: 167, height: 100)
            self.view.addSubview(moodDescription)
        //}
    }
    // SelectedCell still has it's contents in viewDidLoad()
    // Grabbing content through it's tags
    override func viewDidLoad() {
        super.viewDidLoad()
        // Checking to see if selectedCell has a value
        if let passedCell = selectedCell {
            selectedCellImageWeather = passedCell.viewWithTag(100) as? UIImageView
            selectedCellWeatherDescription = passedCell.viewWithTag(101) as? UILabel
            selectedCellMoodImage = passedCell.viewWithTag(102) as? UIImageView
            selectedCellMoodDescription = passedCell.viewWithTag(103) as? UILabel
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
