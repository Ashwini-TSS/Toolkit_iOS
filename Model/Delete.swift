//
//  Delete.swift
//  Blue Square
//
//  Created by mac on 17/09/21.
//  Copyright © 2021 VividInfotech. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct DeleteModal: Codable {
    let valid: Bool?
    let stackMessage: String?
    let responseMessage: String?

    enum CodingKeys: String, CodingKey {
        case valid = "Valid"
        case stackMessage = "StackMessage"
        case responseMessage = "ResponseMessage"
    }
}
