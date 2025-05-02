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
    let valid: Bool?
    let stackMessage: String?
    let twoFARequired: Bool?
    let responseMessage, passKey: String?

    enum CodingKeys: String, CodingKey {
        case valid = "Valid"
        case stackMessage = "StackMessage"
        case twoFARequired = "TwoFARequired"
        case responseMessage = "ResponseMessage"
        case passKey = "PassKey"
    }
}
