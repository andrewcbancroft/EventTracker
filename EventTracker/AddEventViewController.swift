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
    
    var delegate: EventAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.eventStartDatePicker.setDate(initialDatePickerValue(), animated: false)
        self.eventEndDatePicker.setDate(initialDatePickerValue(), animated: false)
    }
    
    func initialDatePickerValue() -> NSDate {
        let calendarUnitFlags: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute, .Second]
        
        let dateComponents = NSCalendar.currentCalendar().components(calendarUnitFlags, fromDate: NSDate())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addEventButtonTapped(sender: UIBarButtonItem) {
        // Create an Event Store instance
        let eventStore = EKEventStore();
        
        // Use Event Store to create a new calendar instance
        if let calendarForEvent = eventStore.calendarWithIdentifier(self.calendar.calendarIdentifier)
        {
            let newEvent = EKEvent(eventStore: eventStore)
            
            newEvent.calendar = calendarForEvent
            newEvent.title = self.eventNameTextField.text ?? "Some Event Name"
            newEvent.startDate = self.eventStartDatePicker.date
            newEvent.endDate = self.eventEndDatePicker.date
            
            // Save the event using the Event Store instance
            do {
                try eventStore.saveEvent(newEvent, span: .ThisEvent, commit: true)
                delegate?.eventDidAdd()
                
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
