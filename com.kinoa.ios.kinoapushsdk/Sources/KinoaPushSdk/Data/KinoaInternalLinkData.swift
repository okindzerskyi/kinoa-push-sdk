//
//  KinoaInternalLinkData.swift
//
//
//  Created by user on 09.05.2024.
//

import Foundation

public struct KinoaInternalLinkData : Codable {
    /// `type` Kinoa interanal link type.
    public private(set) var type: String
    /// `value` Kinoa interanal link value.
    public private(set) var value: String
    
    /**
    Returns `KinoaInternalLinkData.
     
    - Parameter type: Kinoa interanal link type.
    - Parameter value: Kinoa InApp ID.
    */
    public init(type: String, value: String) {
        self.type = type
        self.value = value
    }
}

public enum KinoaInternalLinkType : Codable {
    case addressable
    case web_url
    case local_path
    case text
}
