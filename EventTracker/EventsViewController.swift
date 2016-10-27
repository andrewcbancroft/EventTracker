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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Create start and end date NSDate instances to build a predicate for which events to select
        let startDate = dateFormatter.date(from: "2016-01-01")
        let endDate = dateFormatter.date(from: "2016-12-31")
        
        if let startDate = startDate, let endDate = endDate {
            let eventStore = EKEventStore()
            
            // Use an event store instance to create and properly configure an NSPredicate
            let eventsPredicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: [calendar])
            
            // Use the configured NSPredicate to find and return events in the store that match
            self.events = eventStore.events(matching: eventsPredicate).sorted(){
                (e1: EKEvent, e2: EKEvent) -> Bool in
                return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = events {
            return events.count
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        cell.textLabel?.text = events?[(indexPath as NSIndexPath).row].title
        return cell
    }
}
