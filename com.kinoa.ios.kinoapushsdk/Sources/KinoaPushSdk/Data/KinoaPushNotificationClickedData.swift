//
//  KinoaPushNotificationClickedData.swift
//
//
//  Created by user on 09.05.2024.
//

import Foundation

public struct KinoaPushNotificationClickedData : Codable {
    /// `notificationIdentifier` Kinoa push notification identifier.
    public private(set) var notificationIdentifier: String

    /// `campaignId` Kinoa push notification campaign identifier.
    public private(set) var campaignId: String

    /// `iterationNumber` Kinoa push notification campaign iteration number.
    public internal(set) var iterationNumber: String?

    /// `inAppData`  Kinoa push notification InApp data.
    public internal(set) var inAppData: KinoaInAppData?

    /// `internalLink`  Kinoa push notification internal link data.
    public internal(set) var internalLink: KinoaInternalLinkData?

    /// `extraData` Kinoa push notification extra data.
    public internal(set) var extraData: Dictionary<String, String>?
    
    /**
    Returns `KinoaPushNotificationClickedData.
    */
    public init(notificationIdentifier: String, campaignId: String) {
        self.notificationIdentifier = notificationIdentifier
        self.campaignId = campaignId
    }
}
