//
//  NoteComment.swift
//  Blue Square
//
//  Created by Sayeed Syed on 10/31/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct NoteCommentModel: Codable {
    let commentdata: [CommnetResults]?
    let valid: Bool?
    let totalResults: Int?
    let responseMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case commentdata = "Results"
        case valid = "Valid"
        case totalResults = "TotalResults"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - Result
struct CommnetResults: Codable {
    let comment, noteID, createdBy, modifiedOn: String?
    let id, createdOn, modifiedBy: String?
    enum CodingKeys: String, CodingKey {
        case comment = "Comment"
        case noteID = "NoteId"
        case createdBy = "CreatedBy"
        case modifiedOn = "ModifiedOn"
        case id = "Id"
        case createdOn = "CreatedOn"
        case modifiedBy = "ModifiedBy"
    }
}
