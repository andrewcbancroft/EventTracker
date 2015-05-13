//
//  ViewController.swift
//  EventTracker
//
//  Created by Andrew Bancroft on 5/4/15.
//  Copyright (c) 2015 Andrew Bancroft. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let eventStore = EKEventStore()
    
	@IBOutlet weak var needPermissionView: UIView!
	@IBOutlet weak var calendarsTableView: UITableView!
	
	var calendars: [EKCalendar]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
	
    override func viewWillAppear(animated: Bool) {
        checkCalendarAuthorizationStatus()
    }
    
	func checkCalendarAuthorizationStatus() {
		let status = EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent)
		
		switch (status) {
			case EKAuthorizationStatus.Authorized:
				loadCalendars()
				refreshTableView()
			case EKAuthorizationStatus.NotDetermined:
				requestAccessToCalendar()
			case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
				needPermissionView.fadeIn()
			default:
				let alert = UIAlertView(title: "Privacy Warning", message: "You have not granted permission for this app to access your Calendar", delegate: nil, cancelButtonTitle: "OK")
				alert.show()
		}
	}
	
	func requestAccessToCalendar() {
		eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
			(accessGranted: Bool, error: NSError!) in
			
			if accessGranted == true {
				dispatch_async(dispatch_get_main_queue(), {
					self.loadCalendars()
					self.refreshTableView()
				})
			} else {
				dispatch_async(dispatch_get_main_queue(), {
					self.needPermissionView.fadeIn()
				})
			}
		})
	}

	func loadCalendars() {
		self.calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent) as? [EKCalendar]
	}
	
	func refreshTableView() {
		calendarsTableView.hidden = false
		calendarsTableView.reloadData()
	}
	
	@IBAction func goToSettingsButtonTapped(sender: UIButton) {
		let openSettingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
		UIApplication.sharedApplication().openURL(openSettingsUrl!)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let calendars = self.calendars {
			return calendars.count
		}
		
		return 0
	}
	
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("basicCell") as! UITableViewCell
		
		if let calendars = self.calendars {
			let calendarName = calendars[indexPath.row].title
			cell.textLabel?.text = calendarName
		} else {
			cell.textLabel?.text = "Unknown Calendar Name"
		}
		
		return cell
	}
}

