//
//  ViewController.swift
//  EventTracker
//
//  Created by Andrew Bancroft on 5/4/15.
//  Copyright (c) 2015 Andrew Bancroft. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
            (accessGranted: Bool, error: NSError!) in
            
            if accessGranted == true {
                // take action based on the granted permission
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

