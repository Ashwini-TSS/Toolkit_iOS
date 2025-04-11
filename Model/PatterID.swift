//
//  PatterID.swift
//  Blue Square
//
//  Created by mac on 17/09/21.
//  Copyright © 2021 VividInfotech. All rights reserved.
//

import Foundation

struct PatterID: Codable {
    let dataObject: DataObject
    let valid: Bool?
    let stackMessage: String?
    let responseMessage: String

    enum CodingKeys: String, CodingKey {
        case dataObject = "DataObject"
        case valid = "Valid"
        case stackMessage = "StackMessage"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - DataObject
struct DataObject: Codable {
    let dataObjectDescription, recurrenceDeleteMode, createdBy, endTime: String?
    let modifiedOn: String?
    let rollOver: Bool?
    let activityType: String?
    let appointmentTypeID: String?
    let startTime, recurrenceStart: String?
    let lastCreatedIndex: Int?
    let modifiedBy, subject: String?
    let allDay: Bool?
    let recurrenceEnd: String?
    let staticDeliverableTemplateID: String?
    let id, createdOn, recurrencePatternID: String?
    let serviceMatrixTemplateID: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case dataObjectDescription = "Description"
        case recurrenceDeleteMode = "RecurrenceDeleteMode"
        case createdBy = "CreatedBy"
        case endTime = "EndTime"
        case modifiedOn = "ModifiedOn"
        case rollOver = "RollOver"
        case activityType = "ActivityType"
        case appointmentTypeID = "AppointmentTypeId"
        case startTime = "StartTime"
        case recurrenceStart = "RecurrenceStart"
        case lastCreatedIndex = "LastCreatedIndex"
        case modifiedBy = "ModifiedBy"
        case subject = "Subject"
        case allDay = "AllDay"
        case recurrenceEnd = "RecurrenceEnd"
        case staticDeliverableTemplateID = "StaticDeliverableTemplateId"
        case id = "Id"
        case createdOn = "CreatedOn"
        case recurrencePatternID = "RecurrencePatternId"
        case serviceMatrixTemplateID = "ServiceMatrixTemplateId"
        case location = "Location"
    }
}
