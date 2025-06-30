//
//  KinoaInAppData.swift
//
//
//  Created by user on 09.05.2024.
//

import Foundation

public struct KinoaInAppData : Codable {
    /// `inAppHash` Kinoa InApp hash.
    public private(set) var inAppHash: String
    /// `inAppId` Kinoa InApp ID.
    public private(set) var inAppId: String
    /// `launchTs` Kinoa InApp launch timestamp.
    public private(set) var launchTs: Int
    
    /**
    Returns `KinoaInAppData.
     
    - Parameter inAppHash: Kinoa InApp hash..
    - Parameter inAppId: Kinoa InApp ID.
    - Parameter launchTs: Kinoa InApp launch timestamp.
    */
    public init(inAppHash: String, inAppId: String, launchTs: Int) {
        self.inAppHash = inAppHash
        self.inAppId = inAppId
        self.launchTs = launchTs
    }
}
