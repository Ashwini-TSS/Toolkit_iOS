//
//  JZAllDayEvent.swift
//  JZCalendarWeekView
//
//  Created by Jeff Zhang on 24/5/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

open class JZAllDayEvent: JZBaseEvent {

    /// If a event is All-Day, then it will be shown at top of calendarView
    public var isAllDay: Bool
    
    public init(id: String, startDate: Date, endDate: Date, isAllDay: Bool, advocateProcessIndex:Int, allDay: Bool, appliedAdvocateProcessId : String, appointmentTypeId:AnyObject, complete:Bool, createdBy:String, createdOn :String, descriptionField: String, endTime:String, location:String, modifiedBy:String, modifiedOn:String, recurrenceIndex:Int, recurringActivityId:AnyObject, rollOver:Bool, startTime: String, subject:String, type:String, DueTime:String, AppointmentTypeId: String, PercentComplete:NSNumber, Priority:String, Color :String) {
        self.isAllDay = isAllDay
        super.init(id: id, startDate: startDate, endDate: endDate, advocateProcessIndex: advocateProcessIndex, allDay: allDay, appliedAdvocateProcessId: appliedAdvocateProcessId, appointmentTypeId: appointmentTypeId, complete: complete, createdBy: createdBy, createdOn: createdOn, descriptionField: descriptionField, endTime: endTime, location:location, modifiedBy: modifiedBy
            , modifiedOn: modifiedOn, recurrenceIndex: recurrenceIndex, recurringActivityId: recurringActivityId, rollOver: rollOver, startTime: startTime, subject: subject, type: type, DueTime: DueTime, AppointmentTypeId: AppointmentTypeId, PercentComplete: PercentComplete, Priority: Priority, Color: Color)
    }

    open override func copy(with zone: NSZone?) -> Any {
        return JZAllDayEvent(id: id, startDate: startDate, endDate: endDate, isAllDay: isAllDay,advocateProcessIndex: advocateProcessIndex, allDay: allDay, appliedAdvocateProcessId: appliedAdvocateProcessId, appointmentTypeId: appointmentTypeId, complete: complete, createdBy: createdBy, createdOn: createdOn, descriptionField: descriptionField, endTime: endTime, location:location, modifiedBy: modifiedBy
            , modifiedOn: modifiedOn, recurrenceIndex: recurrenceIndex, recurringActivityId: recurringActivityId, rollOver: rollOver, startTime: startTime, subject: subject, type: type, DueTime: DueTime, AppointmentTypeId: AppointmentTypeId, PercentComplete: PercentComplete, Priority: Priority, Color:
        Color)
    }

}
