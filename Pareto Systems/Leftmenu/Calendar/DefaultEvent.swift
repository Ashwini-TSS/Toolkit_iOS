//
//  DefaultEvent.swift
//  JZCalendarWeekViewExample
//
//  Created by Jeff Zhang on 30/5/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import JZCalendarWeekView

class DefaultEvent: JZBaseEvent {

    var defaultlocation: String
    var title: String

    init(id: String, title: String, startDate: Date, endDate: Date, defaultlocation: String,advocateProcessIndex:Int, allDay: Bool, appliedAdvocateProcessId : String, appointmentTypeId:AnyObject, complete:Bool, createdBy:String, createdOn :String, descriptionField: String, endTime:String, location:String, modifiedBy:String, modifiedOn:String, recurrenceIndex:Int, recurringActivityId:AnyObject, rollOver:Bool, startTime: String, subject:String,type:String, DueTime:String, AppointmentTypeId: String, PercentComplete:NSNumber, Priority:String,Color:String) {
        self.defaultlocation = defaultlocation
        self.title = title

        // If you want to have you custom uid, you can set the parent class's id with your uid or UUID().uuidString (In this case, we just use the base class id)
        super.init(id: id, startDate: startDate, endDate: endDate, advocateProcessIndex: advocateProcessIndex, allDay: allDay, appliedAdvocateProcessId: appliedAdvocateProcessId, appointmentTypeId: appointmentTypeId, complete: complete, createdBy: createdBy, createdOn: createdOn, descriptionField: descriptionField, endTime: endTime, location:location, modifiedBy: modifiedBy
            , modifiedOn: modifiedOn, recurrenceIndex: recurrenceIndex, recurringActivityId: recurringActivityId, rollOver: rollOver, startTime: startTime, subject: subject,type: type, DueTime: DueTime, AppointmentTypeId: AppointmentTypeId, PercentComplete: PercentComplete, Priority: Priority, Color: Color)
    }

    override func copy(with zone: NSZone?) -> Any {
        return DefaultEvent(id: id, title: title, startDate: startDate, endDate: endDate, defaultlocation: defaultlocation,advocateProcessIndex: advocateProcessIndex, allDay: allDay, appliedAdvocateProcessId: appliedAdvocateProcessId, appointmentTypeId: appointmentTypeId, complete: complete, createdBy: createdBy, createdOn: createdOn, descriptionField: descriptionField,endTime: endTime, location: location, modifiedBy: modifiedBy, modifiedOn: modifiedOn, recurrenceIndex: recurrenceIndex, recurringActivityId: recurringActivityId, rollOver: rollOver, startTime: startTime, subject: subject, type: type, DueTime: DueTime, AppointmentTypeId: AppointmentTypeId, PercentComplete: PercentComplete, Priority: Priority, Color: Color)
    }
}
