//
//  GetAppointmentModel.swift
//  Blue Square
//
//  Created by Tecnovators on 17/07/21.
//  Copyright © 2021 VividInfotech. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GetAppointmentModelModel: Codable {
    let results: [GetAppointmentModelData]
    let valid: Bool?
    let totalResults: Int?
    let stackMessage: JSONNull?
    let responseMessage: String?

    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case valid = "Valid"
        case totalResults = "TotalResults"
        case stackMessage = "StackMessage"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - Result
struct GetAppointmentModelData: Codable {
    let resultDescription: String?
    let createdBy: String?
    let endTime: String?
    let modifiedOn: String?
    let advocateProcessIndex: Int?
    let rollOver, complete: Bool?
    let appointmentTypeID: String?
    let startTime: String?
    let externalScheduleID: String?
    let appliedAdvocateProcessID: String?
    let modifiedBy: String?
    let subject:String?
    let recurrenceIndex: Int?
    let allDay: Bool?
    let id, createdOn: String?
    let customProps: String?
    let recurringActivityID, location: String?

    enum CodingKeys: String, CodingKey {
        case resultDescription = "Description"
        case createdBy = "CreatedBy"
        case endTime = "EndTime"
        case modifiedOn = "ModifiedOn"
        case advocateProcessIndex = "AdvocateProcessIndex"
        case rollOver = "RollOver"
        case complete = "Complete"
        case appointmentTypeID = "AppointmentTypeId"
        case startTime = "StartTime"
        case externalScheduleID = "ExternalScheduleId"
        case appliedAdvocateProcessID = "AppliedAdvocateProcessId"
        case modifiedBy = "ModifiedBy"
        case subject = "Subject"
        case recurrenceIndex = "RecurrenceIndex"
        case allDay = "AllDay"
        case id = "Id"
        case createdOn = "CreatedOn"
        case customProps = "CustomProps"
        case recurringActivityID = "RecurringActivityId"
        case location = "Location"
    }
}


