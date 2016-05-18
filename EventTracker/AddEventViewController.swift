//
//  AddEventViewController.swift
//  EventTracker
//
//  Created by Andrew Bancroft on 5/18/16.
//  Copyright © 2016 Andrew Bancroft. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController {

    var calendar: EKCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addCalendarButtonTapped(sender: UIBarButtonItem) {
        
    }
}
