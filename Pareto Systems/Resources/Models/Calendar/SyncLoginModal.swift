//
//  SyncLoginModal.swift
//  Blue Square
//
//  Created by Gowrisankar G on 17/04/25.
//  Copyright © 2025 VividInfotech. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct SyncLoginModal: Codable {
    let success: Bool?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let kind, etag, id, status: String?
    let htmlLink: String?
    let created, updated, summary, description: String?
    let location: String?
    let creator, organizer: Creator?
    let start, end: End?
    let iCalUID: String?
    let sequence: Int?
    let extendedProperties: ExtendedProperties?
    let reminders: Reminders?
    let eventType: String?
}

// MARK: - Creator
struct Creator: Codable {
    let email: String?
    let creatorSelf: Bool?

    enum CodingKeys: String, CodingKey {
        case email
        case creatorSelf = "self"
    }
}

// MARK: - End
struct End: Codable {
    let dateTime: String?
    let timeZone: String?
}

// MARK: - ExtendedProperties
struct ExtendedProperties: Codable {
    let extendedPropertiesPrivate: Private?

    enum CodingKeys: String, CodingKey {
        case extendedPropertiesPrivate = "private"
    }
}

// MARK: - Private
struct Private: Codable {
    let eventType: String?
}

// MARK: - Reminders
struct Reminders: Codable {
    let useDefault: Bool?
}
