//
//  DummyModal.swift
//  Blue Square
//
//  Created by AshwiniSankar on 11/06/20.
//  Copyright © 2020 VividInfotech. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct DummyModal: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let datumDescription, createdBy: String?
    let endTime: String?
    let modifiedOn, advocateProcessIndex, rollOver, complete: String?
    let appointmentTypeID: String?
    let startTime: String?
    let appliedAdvocateProcessID, modifiedBy, subject, recurrenceIndex: String?
    let allDay, id, createdOn, recurringActivityID: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case datumDescription = "Description"
        case createdBy = "CreatedBy"
        case endTime = "EndTime"
        case modifiedOn = "ModifiedOn"
        case advocateProcessIndex = "AdvocateProcessIndex"
        case rollOver = "RollOver"
        case complete = "Complete"
        case appointmentTypeID = "AppointmentTypeId"
        case startTime = "StartTime"
        case appliedAdvocateProcessID = "AppliedAdvocateProcessId"
        case modifiedBy = "ModifiedBy"
        case subject = "Subject"
        case recurrenceIndex = "RecurrenceIndex"
        case allDay = "AllDay"
        case id = "Id"
        case createdOn = "CreatedOn"
        case recurringActivityID = "RecurringActivityId"
        case location = "Location"
    }
}

