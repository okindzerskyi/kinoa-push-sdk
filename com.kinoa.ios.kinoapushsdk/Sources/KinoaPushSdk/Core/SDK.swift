//
//  SDK.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class SDK {
    public static var instance = SDK()
    
    public private(set) var gameSecrets: GameSecrets?
    public private(set) var webRoutes: WebRoutes?
    private var isInitialized: Bool = false
    private var kinoaPushService: KinoaPushService
    
    private init() {
        kinoaPushService = KinoaPushService()
    }
    
    public func initialize(gameSecrets: GameSecrets, webRoutes: WebRoutes) {
        if (isInitialized) { return }
        
        self.gameSecrets = gameSecrets
        self.webRoutes = webRoutes
        self.isInitialized = true
    }
    
    public func setPlayer(playerId: String) async
    {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return
        }
        
        if (KinoaPlayer.instance.isUpdated(playerId: playerId)) {
            await deleteToken(token: getCachedToken());
        }
        
        if (KinoaPlayer.instance.update(playerId: playerId)) {
            requestTokenRegistration();
        }
        
        Task {
            let notifications = await UNUserNotificationCenter.current().deliveredNotifications()
            let badgeCount = notifications.count
            if #available(iOS 16.0, *) {
                try? await UNUserNotificationCenter.current().setBadgeCount(badgeCount)
            }
            let response = await kinoaPushService.updateBadgeCounter(playerId: KinoaPlayer.instance.playerId, badgeCounterValue: badgeCount)
            
            print("Update Badge Counter Kinoa Response: \(response!.httpResponse.statusCode)")
        }
    }
    
    private func requestTokenRegistration() {
        let token = Preferences.get(defaultValue: "", forKey: KinoaCacheConstants.ApnRegistrationToken)
        if (token.isEmpty) { return }
        let defaultValue : Int64 = 0
        let tokenGeneratedTs = Preferences.get(defaultValue: defaultValue, forKey: KinoaCacheConstants.ApnRegistrationTokenTimestamp)
        let lastLoginTs = Date().currentTimeMillis()
        if (!validatePlayerId()) { return }
        Task {
            let response = await kinoaPushService.registerToken(
                playerId: KinoaPlayer.instance.playerId,
                deviceToken: token,
                tokenGeneratedTs: tokenGeneratedTs,
                lastLoginTs: lastLoginTs)
            print("Register Token Kinoa Response: \(response!.httpResponse.statusCode)")
        
        }
    }
    
    public func registerToken(token: String) async -> KinoaResponse? {
        let tokenGeneratedTs = Date().currentTimeMillis()
        saveTokenDataToPrefs(token: token, tokenGeneratedTs: tokenGeneratedTs)
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.registerToken(
            playerId: KinoaPlayer.instance.playerId,
            deviceToken: token,
            tokenGeneratedTs: tokenGeneratedTs,
            lastLoginTs: tokenGeneratedTs)
    }
    
    public func deleteToken(token: String) async -> KinoaResponse? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.deleteToken(
            playerId: KinoaPlayer.instance.playerId,
            deviceToken: token)
    }
    
    public func getCachedToken() -> String {
        return Preferences.get(defaultValue: "", forKey: KinoaCacheConstants.ApnRegistrationToken)
    }
    
    private func saveTokenDataToPrefs(token: String, tokenGeneratedTs: Int64) {
        Preferences.set(value: token, forKey: KinoaCacheConstants.ApnRegistrationToken)
        Preferences.set(value: tokenGeneratedTs, forKey: KinoaCacheConstants.ApnRegistrationTokenTimestamp)
        UserDefaults.standard.synchronize()
    }
    
    public func blockPushes() async -> KinoaResponse? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.blockPushes(playerId: KinoaPlayer.instance.playerId)
    }
    
    public func unblockPushes() async -> KinoaResponse? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.unblockPushes(playerId: KinoaPlayer.instance.playerId)
    }
    
    public func getPushesStatus() async -> KinoaResponseT<KinoaPushesStatus>? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.getPushesStatus(playerId: KinoaPlayer.instance.playerId)
    }
    
    public func updatePushClickAnalytic(pushClickAnalyticData: KinoaPushClickAnalyticData) async -> KinoaResponse? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.updatePushClickAnalytic(playerId: KinoaPlayer.instance.playerId, pushClickAnalyticData: pushClickAnalyticData)
    }
    
    public func getPushPersonalizationInfo() async -> KinoaResponseT<KinoaPushPersonalizationInfo>? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.getPushPersonalizationInfo(playerId: KinoaPlayer.instance.playerId)
    }
    
    public func setPushPersonalizationInfo(pushPersonalizationInfo: KinoaPushPersonalizationInfo) async -> KinoaResponse? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.setPushPersonalizationInfo(playerId: KinoaPlayer.instance.playerId, pushPersonalizationInfo: pushPersonalizationInfo)
    }
    
    public func deletePushPersonalizationInfo() async -> KinoaResponse? {
        if (!isInitialized) {
            KinoaLogger.instance.LOG(message: "Kinoa Push SDK is not initialized.")
            return nil
        }
        if (!validatePlayerId()) { return nil }
        return await kinoaPushService.deletePushPersonalizationInfo(playerId: KinoaPlayer.instance.playerId)
    }
    
    public func processClickedNotification(notification: UNNotification?) -> KinoaPushNotificationClickedData? {
        if (notification != nil) {
            return KinoaPushClickedHandler.instance.process(notification: notification!)
        }
        return nil
    }
    
    private func validatePlayerId() -> Bool {
        if (KinoaPlayer.instance.playerId.isEmpty) {
            KinoaLogger.instance.LOG(message: "Player ID can`t be empty")
            return false
        }
        return true
    }
}
