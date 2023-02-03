//
//  JZBaseEvent.swift
//  JZCalendarWeekView
//
//  Created by Jeff Zhang on 29/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

open class JZBaseEvent: NSObject, NSCopying {

    /// Unique id for each event to identify an event, especially for cross-day events
    public var id: String

    public var startDate: Date
    public var endDate: Date

    // If a event crosses two days, it should be devided into two events but with different intraStartDate and intraEndDate
    // eg. startDate = 2018.03.29 14:00 endDate = 2018.03.30 03:00, then two events should be generated: 1. 0329 14:00 - 23:59(IntraEnd) 2. 0330 00:00(IntraStart) - 03:00
    public var intraStartDate: Date
    public var intraEndDate: Date

    // Cutomized changes
    public var advocateProcessIndex : Int!
    public var allDay : Bool!
    public var appliedAdvocateProcessId : String!
    public var appointmentTypeId : AnyObject!
    public var complete : Bool!
    public var createdBy : String!
    public var createdOn : String!
    public var descriptionField : String!
    public var endTime : String!
    public var location : String!
    public var modifiedBy : String!
    public var modifiedOn : String!
    public var recurrenceIndex : Int!
    public var recurringActivityId : AnyObject!
    public var rollOver : Bool!
    public var startTime : String!
    public var subject : String!
    public var type : String!
    public var DueTime :String!
    
    public var Color : String!
    
    public var AppointmentTypeId : String!
    public var PercentComplete:NSNumber!
    public var Priority:String!

    public init(id: String, startDate: Date, endDate: Date, advocateProcessIndex:Int, allDay: Bool, appliedAdvocateProcessId : String, appointmentTypeId:AnyObject, complete:Bool, createdBy:String, createdOn :String, descriptionField: String, endTime:String, location:String, modifiedBy:String, modifiedOn:String, recurrenceIndex:Int, recurringActivityId:AnyObject, rollOver:Bool, startTime: String, subject:String, type:String, DueTime:String, AppointmentTypeId: String, PercentComplete:NSNumber, Priority:String , Color:String) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.intraStartDate = startDate
        self.intraEndDate = endDate
        self.advocateProcessIndex = advocateProcessIndex
        self.allDay = allDay
        self.appliedAdvocateProcessId = appliedAdvocateProcessId
        self.appointmentTypeId = appointmentTypeId
        self.complete = complete
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.descriptionField = descriptionField
        self.endTime = endTime
        self.location = location
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.recurrenceIndex = recurrenceIndex
        self.recurringActivityId = recurringActivityId
        self.rollOver = rollOver
        self.startTime = startTime
        self.subject = subject
        self.Color = Color
        self.type = type
        self.DueTime = DueTime
        self.AppointmentTypeId = AppointmentTypeId
        self.appointmentTypeId = appointmentTypeId
        self.PercentComplete = PercentComplete
        self.Priority = Priority
    }

    // Must be overridden
    // Shadow copy is enough for JZWeekViewHelper to create multiple events for cross-day events
    open func copy(with zone: NSZone? = nil) -> Any {
        return JZBaseEvent(id: id, startDate: startDate, endDate: endDate, advocateProcessIndex: advocateProcessIndex, allDay: allDay, appliedAdvocateProcessId: appliedAdvocateProcessId, appointmentTypeId: appointmentTypeId, complete: complete, createdBy: createdBy, createdOn: createdOn, descriptionField: descriptionField, endTime: endTime, location:location, modifiedBy: modifiedBy
            , modifiedOn: modifiedOn, recurrenceIndex: recurrenceIndex, recurringActivityId: recurringActivityId, rollOver: rollOver, startTime: startTime, subject: subject, type: type, DueTime: DueTime, AppointmentTypeId: AppointmentTypeId, PercentComplete: PercentComplete, Priority: Priority,Color:Color)
    }
}
