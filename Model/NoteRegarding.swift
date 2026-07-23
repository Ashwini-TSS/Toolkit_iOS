//
//  NoteRegarding.swift
//  Blue Square
//
//  Created by Sayeed Syed on 10/30/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import Foundation

struct NoteRegardingModel: Codable {
    let regardingobj: [NoteRegardingList]?
    let valid: Bool?
    let totalResults: Int?
    let responseMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case regardingobj = "Results"
        case valid = "Valid"
        case totalResults = "TotalResults"
        case responseMessage = "ResponseMessage"
    }
}

struct NoteRegardingList: Codable {
    let noteID, createdBy, modifiedOn, regardingID: String?
    let regardingType, id, createdOn, modifiedBy: String?
    
    let contentType,fileStoreID, name : String?
    let permissionsMask: Int?
    let size: Int?
    enum CodingKeys: String, CodingKey {
        case noteID = "NoteId"
        case createdBy = "CreatedBy"
        case modifiedOn = "ModifiedOn"
        case regardingID = "RegardingId"
        case regardingType = "RegardingType"
        case id = "Id"
        case createdOn = "CreatedOn"
        case modifiedBy = "ModifiedBy"
        
        case contentType = "ContentType"
        case fileStoreID = "FileStoreId"
        case name = "Name"
        case permissionsMask = "PermissionsMask"
        case size = "Size"
    }
}
