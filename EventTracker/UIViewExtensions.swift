//
//  UIViewExtensions.swift
//  EventTracker
//
//  Created by Andrew Bancroft on 5/4/15.
//  Copyright (c) 2015 Andrew Bancroft. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
		UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
			self.alpha = 1.0
			}, completion: completion)  }
	
	func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
		UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
			self.alpha = 0.0
			}, completion: completion)
	}
}
