//
//  Task.swift
//  Blue Square
//
//  Created by AshwiniSankar on 14/11/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import Foundation

struct Taskmodel: Codable {
       let results: [TaskResult]
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
struct TaskResult: Codable {
    let status: String?
    let resultDescription: String?
    let createdBy, dueTime, modifiedOn: String?
    let advocateProcessIndex: Int?
    let priority: String?
    let rollOver: Bool?
    let startTime: String?
    let appliedAdvocateProcessID: String?
    let modifiedBy: String?
    let subject: String?
    let recurrenceIndex, percentComplete: Int?
    let id, createdOn: String?
    let customProps: JSONNull?
    let recurringActivityID: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case resultDescription = "Description"
        case createdBy = "CreatedBy"
        case dueTime = "DueTime"
        case modifiedOn = "ModifiedOn"
        case advocateProcessIndex = "AdvocateProcessIndex"
        case priority = "Priority"
        case rollOver = "RollOver"
        case startTime = "StartTime"
        case appliedAdvocateProcessID = "AppliedAdvocateProcessId"
        case modifiedBy = "ModifiedBy"
        case subject = "Subject"
        case recurrenceIndex = "RecurrenceIndex"
        case percentComplete = "PercentComplete"
        case id = "Id"
        case createdOn = "CreatedOn"
        case customProps = "CustomProps"
        case recurringActivityID = "RecurringActivityId"
        case location = "Location"
    }
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
