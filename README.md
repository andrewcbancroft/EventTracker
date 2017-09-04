# EventTracker

## Major changes to the monkeywithacupcake Version
While testing some swift code, I made major changes to the original. The functionality now includes:

* The date limits for the events listed for calendars are limited to 1 year from (today)...whenever that is. This allows testing of the "add event" function 
* There is now a button to view whatever calendar's event list on a calendar view powered by [JTAppleCalendar](https://github.com/patchthecode/JTAppleCalendar). The calendar view shows:
  * A scrollable monthly calendar
  * A small orange square for any day with events
  * A list of event titles for any day with events
  * A note when there are no events
  * A button to return to today (this month)
  * A button to return to the event list 

## Resources from Andrew Bancroft
This repository contains an example Xcode project for the following blog posts at [andrewcbancroft.com](http://www.andrewcbancroft.com):

* [Beginner’s Guide to Event Kit in Swift – Requesting Permission](http://www.andrewcbancroft.com/2015/05/14/beginners-guide-to-eventkit-in-swift-requesting-permission/)
* [Creating Calendars with Event Kit and Swift](https://www.andrewcbancroft.com/2015/06/17/creating-calendars-with-event-kit-and-swift/)
* [Listing Calendar Events with Event Kit and Swift](https://www.andrewcbancroft.com/2016/04/28/listing-calendar-events-with-event-kit-and-swift/)
Master contains all merged changes to the EventTracker example.
* [Creating Calendar Events with Event Kit and Swift](https://www.andrewcbancroft.com/2016/06/02/creating-calendar-events-with-event-kit-and-swift/)

Sub branches relating to each of the blog titles listed contain the project in the state it was in when when the blog post was published.

## Compatibility
Verified that this repository's code works in Xcode 8 and Swift 3.0
