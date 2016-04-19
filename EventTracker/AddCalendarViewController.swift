//
//  AddCalendarViewController.swift
//  EventTracker
//
//  Created by Andrew Bancroft on 4/19/16.
//  Copyright © 2016 Andrew Bancroft. All rights reserved.
//

import UIKit
import EventKit

class AddCalendarViewController: UIViewController {

    @IBOutlet weak var calendarNameTextField: UITextField!
    var delegate: CalendarAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addCalendarButtonTapped(sender: UIBarButtonItem) {
        // Create an Event Store instance
        let eventStore = EKEventStore();
        
        // Use Event Store to create a new calendar instance
        // Configure its title
        let newCalendar = EKCalendar(forEntityType: .Event, eventStore: eventStore)
        
        // Probably want to prevent someone from saving a calendar
        // if they don't type in a name...
        newCalendar.title = calendarNameTextField.text ?? "Some Calendar Name"
        
        // Access list of available sources from the Event Store
        let sourcesInEventStore = eventStore.sources 
        
        // Filter the available sources and select the "Local" source to assign to the new calendar's
        // source property
        newCalendar.source = sourcesInEventStore.filter{
            (source: EKSource) -> Bool in
            source.sourceType.rawValue == EKSourceType.Local.rawValue
            }.first!
        
        // Save the calendar using the Event Store instance
        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
            NSUserDefaults.standardUserDefaults().setObject(newCalendar.calendarIdentifier, forKey: "EventTrackerPrimaryCalendar")
            delegate?.calendarDidAdd()
            self.dismissViewControllerAnimated(true, completion: nil)
        } catch {
            let alert = UIAlertController(title: "Calendar could not save", message: (error as NSError).localizedDescription, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
