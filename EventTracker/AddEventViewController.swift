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

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventStartDatePicker: UIDatePicker!
    @IBOutlet weak var eventEndDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addEventButtonTapped(sender: UIBarButtonItem) {
            // Create an Event Store instance
        let eventStore = EKEventStore();
        
        if let calendarForEvent = eventStore.calendarWithIdentifier((self.calendar.calendarIdentifier))
        {
            // Use Event Store to create a new calendar instance
            // Configure its title
            let newEvent = EKEvent(eventStore: eventStore)
            
            // Probably want to prevent someone from saving a calendar
            // if they don't type in a name...
            newEvent.calendar = calendarForEvent
            newEvent.title = self.eventNameTextField.text ?? "Some Event Name"
            newEvent.startDate = self.eventStartDatePicker.date
            newEvent.endDate = self.eventEndDatePicker.date
            
            // Save the calendar using the Event Store instance
            
            do {
                try eventStore.saveEvent(newEvent, span: .ThisEvent, commit: true)
                
                self.dismissViewControllerAnimated(true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(OKAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
     }
}
