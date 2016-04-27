//
//  EventsViewController.swift
//  EventTracker
//
//  Created by Andrew Bancroft on 4/26/16.
//  Copyright © 2016 Andrew Bancroft. All rights reserved.
//

import UIKit
import EventKit

class EventsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var calendar: EKCalendar!
    var events: [EKEvent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
    }
    
    func loadEvents() {
        // Create a date formatter instance to use for converting a string to a date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Create start and end date NSDate instances to build a predicate for which events to select
        let startDate = dateFormatter.dateFromString("2016-01-01")
        let endDate = dateFormatter.dateFromString("2016-12-31")
        
        if let startDate = startDate, endDate = endDate {
            let eventStore = EKEventStore()
            
            // Use an event store instance to create and properly configure an NSPredicate
            let eventsPredicate = eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: [calendar])
            
            // Use the configured NSPredicate to find and return events in the store that match
            self.events = eventStore.eventsMatchingPredicate(eventsPredicate).sort(){
                (e1: EKEvent, e2: EKEvent) -> Bool in
                return e1.startDate.compare(e2.startDate) == NSComparisonResult.OrderedAscending
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = events {
            return events.count
        }
        
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell")!
        cell.textLabel?.text = events?[indexPath.row].title
        return cell
    }
}
