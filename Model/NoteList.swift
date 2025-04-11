//
//  NoteList.swift
//  Blue Square
//
//  Created by Sayeed Syed on 10/30/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
import Foundation

// MARK: - NoteModel
struct NoteModel: Codable {
    let notedata: [NoteList]?
    let valid: Bool?
    let totalResults: Int?
    let responseMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case notedata = "Results"
        case valid = "Valid"
        case totalResults = "TotalResults"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - NoteList
struct NoteList: Codable {
    let note: Note?
    let regarding, attachments: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case note = "Note"
        case regarding = "Regarding"
        case attachments = "Attachments"
    }
}
// MARK: - Note
struct Note: Codable {
    let draft: Bool
    let createdBy, modifiedOn: String
    let note: String?
    let id, createdOn, modifiedBy: String
    
    enum CodingKeys: String, CodingKey {
        case draft = "Draft"
        case createdBy = "CreatedBy"
        case modifiedOn = "ModifiedOn"
        case note = "Note"
        case id = "Id"
        case createdOn = "CreatedOn"
        case modifiedBy = "ModifiedBy"
    }
}
