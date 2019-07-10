//
//  Task.swift
//  Blue Square
//
//  Created by AshwiniSankar on 14/11/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import Foundation

struct Taskmodel: Codable {
    let valid: Bool
    let totalResults: Int
    let activities: [ActivityElement]
    let responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case valid = "Valid"
        case totalResults = "TotalResults"
        case activities = "Activities"
        case responseMessage = "ResponseMessage"
    }
}

struct ActivityElement: Codable {
    let attendees: JSONNull?
    let type: TypeEnum
    let activity: ActivityClass
    
    enum CodingKeys: String, CodingKey {
        case attendees = "Attendees"
        case type = "Type"
        case activity = "Activity"
    }
}

struct ActivityClass: Codable {
    let appliedAdvocateProcessID: String?
    let subject: String
    let priority: ActivityPriority
    let rollOver: Bool
    let advocateProcessIndex: Int
    let startTime, modifiedBy, createdBy: String
    let percentComplete: Int
    let location: String?
    let status: ActiviytStatus
    let id, modifiedOn: String
    let description: String?
    let dueTime, createdOn: String
    let recurrenceIndex: Int
    let recurringActivityID: String?
    
    enum CodingKeys: String, CodingKey {
        case appliedAdvocateProcessID = "AppliedAdvocateProcessId"
        case subject = "Subject"
        case priority = "Priority"
        case rollOver = "RollOver"
        case advocateProcessIndex = "AdvocateProcessIndex"
        case startTime = "StartTime"
        case modifiedBy = "ModifiedBy"
        case createdBy = "CreatedBy"
        case percentComplete = "PercentComplete"
        case location = "Location"
        case status = "Status"
        case id = "Id"
        case modifiedOn = "ModifiedOn"
        case description = "Description"
        case dueTime = "DueTime"
        case createdOn = "CreatedOn"
        case recurrenceIndex = "RecurrenceIndex"
        case recurringActivityID = "RecurringActivityId"
    }
}

enum ActivityPriority: String, Codable {
    case low = "Low"
    case normal = "Normal"
}

enum ActiviytStatus: String, Codable {
    case inProgress = "InProgress"
    case notStarted = "NotStarted"
}

enum TypeEnum: String, Codable {
    case task = "Task"
}
// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
