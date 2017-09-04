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
    var eventStore : EKEventStore!

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventStartDatePicker: UIDatePicker!
    @IBOutlet weak var eventEndDatePicker: UIDatePicker!
    
    var delegate: EventAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore = EKEventStore()
        self.eventStartDatePicker.setDate(initialDatePickerValue(), animated: false)
        self.eventEndDatePicker.setDate(initialDatePickerValue(), animated: false)
    }
    
    func initialDatePickerValue() -> Date {
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addEventButtonTapped(_ sender: UIBarButtonItem) {
        // Create an Event Store instance
        //let eventStore = EKEventStore();
        print("adding event to \(calendar.title)")
        // Use Event Store to create a new calendar instance
        //if let calendarForEvent = calendar {
        //if let calendarForEvent = eventStore.calendar(withIdentifier: self.calendar.calendarIdentifier)
            print("there is a calendar")
            let newEvent = EKEvent(eventStore: self.eventStore)
            newEvent.calendar = calendar
            newEvent.title = self.eventNameTextField.text ?? "Some Event Name"
            newEvent.startDate = self.eventStartDatePicker.date
            newEvent.endDate = self.eventEndDatePicker.date
            print(newEvent.calendar.title)
            print(newEvent.title)
            print(newEvent.startDate)
            print(newEvent.endDate)

            // Save the event using the Event Store instance
            do {
                print("trying to save")
                try self.eventStore.save(newEvent, span: .thisEvent)

                delegate?.eventDidAdd()
                
                self.dismiss(animated: true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        //}
     }
}
