//
//  CustomCell.swift
//  EventTracker
//
//  Created by Jess Chandler on 9/3/17.
//  Copyright © 2017 Andrew Bancroft. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CustomCell: JTAppleCell {

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var highlightCircle: UIView!

    @IBOutlet weak var activeLine: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        defineHighlightCircle(myView: highlightCircle)
    }

    func defineHighlightCircle(myView: UIView){
        let size:CGFloat = 30.0
        myView.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        myView.layer.cornerRadius = size / 2
        myView.layer.borderWidth = 1
        myView.layer.borderColor = UIColor.black.cgColor
    }

}
