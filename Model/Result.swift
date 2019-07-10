// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct ResultModel: Codable {
    let results: [Result]
    let valid: Bool
    let responseMessage: String
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case valid = "Valid"
        case responseMessage = "ResponseMessage"
        case totalResults = "TotalResults"
    }
}

struct Result: Codable {
    let modifiedOn: EdOn
    let subject: Subject
    let recurrenceIndex: Int
    let status: Status
    let appliedAdvocateProcessID: JSONNNull?
    let id: String
    let advocateProcessIndex: Int
    let rollOver: Bool
    let startTime: String
    let priority: Priority
    let location: Location?
    let dueTime, modifiedBy: String
    let description: Description?
    let createdBy: String
    let recurringActivityID: String?
    let createdOn: EdOn
    let percentComplete: Int
    
    enum CodingKeys: String, CodingKey {
        case modifiedOn = "ModifiedOn"
        case subject = "Subject"
        case recurrenceIndex = "RecurrenceIndex"
        case status = "Status"
        case appliedAdvocateProcessID = "AppliedAdvocateProcessId"
        case id = "Id"
        case advocateProcessIndex = "AdvocateProcessIndex"
        case rollOver = "RollOver"
        case startTime = "StartTime"
        case priority = "Priority"
        case location = "Location"
        case dueTime = "DueTime"
        case modifiedBy = "ModifiedBy"
        case description = "Description"
        case createdBy = "CreatedBy"
        case recurringActivityID = "RecurringActivityId"
        case createdOn = "CreatedOn"
        case percentComplete = "PercentComplete"
    }
}

enum EdOn: String, Codable {
    case the20181107T120651000Z = "2018-11-07T12:06:51.000Z"
    case the20181107T120841000Z = "2018-11-07T12:08:41.000Z"
    case the20181107T120842000Z = "2018-11-07T12:08:42.000Z"
    case the20181107T120902000Z = "2018-11-07T12:09:02.000Z"
    case the20181107T120952000Z = "2018-11-07T12:09:52.000Z"
    case the20181107T121143000Z = "2018-11-07T12:11:43.000Z"
    case the20181107T121509000Z = "2018-11-07T12:15:09.000Z"
    case the20181107T174658000Z = "2018-11-07T17:46:58.000Z"
    case the20181108T121927000Z = "2018-11-08T12:19:27.000Z"
    case the20181108T151643000Z = "2018-11-08T15:16:43.000Z"
    case the20181108T151701000Z = "2018-11-08T15:17:01.000Z"
    case the20181113T070522000Z = "2018-11-13T07:05:22.000Z"
    case the20181113T070617000Z = "2018-11-13T07:06:17.000Z"
    case the20181114T053552000Z = "2018-11-14T05:35:52.000Z"
    case the20181114T114750000Z = "2018-11-14T11:47:50.000Z"
    case the20181114T120506000Z = "2018-11-14T12:05:06.000Z"
    case the20181115T020027000Z = "2018-11-15T02:00:27.000Z"
}

enum Description: String, Codable {
    case aboutIOS = "About iOS"
    case desc = "desc"
    case description = "Description"
    case testingPareto = "Testing Pareto"
    case testingParetoApp = "Testing Pareto app"
}

enum Location: String, Codable {
    case chennai = "Chennai"
}

enum Priority: String, Codable {
    case high = "High"
    case low = "Low"
    case normal = "Normal"
}

enum Status: String, Codable {
    case completed = "Completed"
    case notStarted = "NotStarted"
}

enum Subject: String, Codable {
    case iOS = "iOS"
    case newTaskForPareto = "New Task For Pareto"
    case subject = "Subject"
    case taskFromThabu = "task from thabu"
    case testPareto = "Test Pareto"
    case the13Nov = "13Nov"
}

// MARK: Encode/decode helpers

class JSONNNull: Codable, Hashable {
    
    public static func == (lhs: JSONNNull, rhs: JSONNNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
