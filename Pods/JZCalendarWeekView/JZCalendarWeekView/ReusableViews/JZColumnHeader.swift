//
//  JZColumnHeader.swift
//  JZCalendarWeekView
//
//  Created by Jeff Zhang on 28/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

/// Header for each column (section, day) in collectionView (Supplementary View)
open class JZColumnHeader: UICollectionReusableView {

    public var lblDay = UILabel()
    public var lblWeekday = UILabel()
    let calendarCurrent = Calendar.current
    public var dateFormatter = DateFormatter()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        backgroundColor = .clear
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Hide all content when colum header height equals 0
        self.clipsToBounds = true
        let stackView = UIStackView(arrangedSubviews: [lblWeekday, lblDay])
        stackView.axis = .vertical
        stackView.spacing = 2
        addSubview(stackView)
        stackView.setAnchorConstraintsEqualTo(heightAnchor: 31.0
            , bottomAnchor: (bottomAnchor, -15), leadingAnchor: (leadingAnchor, -30), trailingAnchor: (trailingAnchor, 0))
        //stackView.setAnchorConstraintsEqualTo(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        lblDay.textAlignment = .center
        lblWeekday.textAlignment = .center
        lblDay.font = UIFont.systemFont(ofSize: 14)//14
        lblWeekday.font = UIFont.systemFont(ofSize: 12)//12
    }

    public func updateView(date: Date) {
        let weekday = calendarCurrent.component(.weekday, from: date) - 1
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        let myString = formatter.string(from: date) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "MMMM d, yyyy"
        let myStringafd = formatter.string(from: yourDate!)
 
        //lblWeekday.text
        
        lblWeekday.text = myStringafd
        lblDay.text = dateFormatter.weekdaySymbols[weekday].uppercased()

        if date.isToday {
            lblDay.textColor = JZWeekViewColors.today
            lblWeekday.textColor = JZWeekViewColors.today
        } else {
//            lblDay.textColor = JZWeekViewColors.columnHeaderDay
//            lblWeekday.textColor = JZWeekViewColors.columnHeaderDay
            lblDay.textColor = JZWeekViewColors.today
            lblWeekday.textColor = JZWeekViewColors.today
        }
    }

}
