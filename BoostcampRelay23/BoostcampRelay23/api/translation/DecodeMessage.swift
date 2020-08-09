//
//  DecodeMessage.swift
//  BoostcampRelay23
//
//  Created by Sue Cho on 2020/08/08.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Entry: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let type, service, version: String
    let result: Result
    
    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case service = "@service"
        case version = "@version"
        case result
    }
}

// MARK: - Result
struct Result: Codable {
    let translatedText, srcLangType: String
}
