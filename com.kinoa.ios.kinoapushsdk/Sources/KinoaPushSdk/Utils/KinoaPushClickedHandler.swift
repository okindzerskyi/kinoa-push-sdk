//
//  File.swift
//  
//
//  Created by user on 10.05.2024.
//

import Foundation
import UserNotifications

@available(iOS 13.0, *)
internal class KinoaPushClickedHandler {
    
    public static var instance = KinoaPushClickedHandler()
    
    private var EXTRA_DATA_KEY = "extraData"
    private var CAMPAIGN_ID_KEY = "campaignId"
    private var ITERATION_NUMBER_KEY = "iterationNumber"
    private var IN_APP_DATA_KEY = "inAppData"
    private var INTERNAL_LINK_KEY = "internalLinkData"
    
    private init(){
    }
    
    public func process(notification: UNNotification) -> KinoaPushNotificationClickedData? {
        
        let userInfo = notification.request.content.userInfo
        let notificationId = notification.request.identifier
        guard let campaignId = userInfo[CAMPAIGN_ID_KEY] as? String else { 
            return nil 
        }
        var clickedData = KinoaPushNotificationClickedData(notificationIdentifier: notificationId, campaignId: campaignId)
        
        let iterationNumber = userInfo[ITERATION_NUMBER_KEY] as? String
        clickedData.iterationNumber = iterationNumber
        
        let decoder = JSONDecoder()
        
        let inAppData = userInfo[IN_APP_DATA_KEY] as? String
        if let inAppData = inAppData, !inAppData.isEmpty {
            let jsonData = Data(inAppData.utf8)
            clickedData.inAppData = try? decoder.decode(KinoaInAppData.self, from: jsonData)
        }

        let internalLinkData = userInfo[INTERNAL_LINK_KEY] as? String
        if let internalLinkData = internalLinkData, !internalLinkData.isEmpty {
            let jsonData = Data(internalLinkData.utf8)
            clickedData.internalLink = try? decoder.decode(KinoaInternalLinkData.self, from: jsonData)
        }

        let extraData = userInfo[EXTRA_DATA_KEY] as? String
        if let extraData = extraData, !extraData.isEmpty {
            let obj = extraData.toJSON() as? Dictionary<String, String>
            clickedData.extraData = obj
        }
        
        Task {
            let analyticData = KinoaPushClickAnalyticData(campaignId: campaignId, iterationNumber: iterationNumber)
            let response = await SDK.instance.updatePushClickAnalytic(pushClickAnalyticData: analyticData)
            if let response = response {
                print("Update Click Analytic Kinoa Response: \(response.httpResponse.statusCode)")
            } else {
                print("Update Click Analytic Kinoa Response: No response received")
            }
        }
            
        return clickedData
    }
}
