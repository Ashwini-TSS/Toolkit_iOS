//
//  BCCTracking.swift
//  Blue Square
//
//  Created by Sayeed Syed on 4/28/20.
//  Copyright © 2020 VividInfotech. All rights reserved.
//

import Foundation

struct BCCTrackingModal: Codable {
    let organizationUserBCCMailTrackingEntries: [OrganizationUserBCCMailTrackingEntry]?
    let valid: Bool?
    let stackMessage: String?
    let responseMessage: String?

    enum CodingKeys: String, CodingKey {
        case organizationUserBCCMailTrackingEntries = "OrganizationUserBCCMailTrackingEntries"
        case valid = "Valid"
        case stackMessage = "StackMessage"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - OrganizationUserBCCMailTrackingEntry
struct OrganizationUserBCCMailTrackingEntry: Codable {
    let createdBy, modifiedOn, userID, createdOn: String?
    let organizationID, modifiedBy, bccAddressPrefix: String?

    enum CodingKeys: String, CodingKey {
        case createdBy = "CreatedBy"
        case modifiedOn = "ModifiedOn"
        case userID = "UserId"
        case createdOn = "CreatedOn"
        case organizationID = "OrganizationId"
        case modifiedBy = "ModifiedBy"
        case bccAddressPrefix = "BccAddressPrefix"
    }
}
