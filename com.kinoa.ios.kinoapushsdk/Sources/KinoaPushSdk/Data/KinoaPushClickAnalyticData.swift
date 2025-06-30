//
//  KinoaPushClickAnalyticData.swift
//  
//
//  Created by user on 09.05.2024.
//

import Foundation

internal struct KinoaPushClickAnalyticData : Codable {
    var platform: String?
    var campaignId: String
    var iterationNumber: String?
    
    public init(campaignId: String, iterationNumber: String?) {
        self.platform = "iOS"
        self.campaignId = campaignId
        self.iterationNumber = iterationNumber
    }
}
