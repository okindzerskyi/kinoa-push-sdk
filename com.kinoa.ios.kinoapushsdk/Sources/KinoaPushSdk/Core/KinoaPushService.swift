//
//  KinoaPushService.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation
import CryptoKit
import UIKit

@available(iOS 13.0, *)
internal class KinoaPushService {
    public func registerToken(playerId: String, deviceToken: String, tokenGeneratedTs: Int64, lastLoginTs: Int64) async -> KinoaResponse? {
        guard let identifierForVendor = UIDevice.current.identifierForVendor else {
            KinoaLogger.instance.LOG(message: "Device identifier not available")
            return nil
        }
        let deviceId = identifierForVendor.uuidString
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices")
            .setMethod(httpMethod: "POST")
            .setPostData(KinoaTokenRegistrationData(
                            deviceToken: deviceToken,
                            tokenGeneratedTs: tokenGeneratedTs,
                            lastLoginTs: lastLoginTs,
                            deviceId: deviceId))
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for token registration")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func deleteToken(playerId: String, deviceToken: String) async -> KinoaResponse? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices")
            .setMethod(httpMethod: "DELETE")
            .addParameter(key: "deviceToken", value: deviceToken)
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for token deletion")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func blockPushes(playerId: String) async -> KinoaResponse? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/block")
            .setMethod(httpMethod: "POST")
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for blocking pushes")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func unblockPushes(playerId: String) async -> KinoaResponse? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/unblock")
            .setMethod(httpMethod: "POST")
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for unblocking pushes")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func getPushesStatus(playerId: String) async -> KinoaResponseT<KinoaPushesStatus>? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/blocked")
            .setMethod(httpMethod: "GET")
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for getting push status")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponseT(
                KinoaPushesStatus.self, data: data, response: response)
        }
        catch {}
        return nil
    }
    
    public func updatePushClickAnalytic(playerId: String, pushClickAnalyticData: KinoaPushClickAnalyticData) async -> KinoaResponse? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/analytic/click")
            .setMethod(httpMethod: "POST")
            .setPostData(pushClickAnalyticData)
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for updating push click analytic")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func setPushPersonalizationInfo(playerId: String, pushPersonalizationInfo: KinoaPushPersonalizationInfo) async -> KinoaResponse? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/info")
            .setMethod(httpMethod: "POST")
            .setPostData(pushPersonalizationInfo)
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for setting push personalization info")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func getPushPersonalizationInfo(playerId: String) async -> KinoaResponseT<KinoaPushPersonalizationInfo>? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/info")
            .setMethod(httpMethod: "GET")
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for getting push personalization info")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponseT(
                KinoaPushPersonalizationInfo.self, data: data, response: response)
        }
        catch {}
        return nil
    }
    
    public func deletePushPersonalizationInfo(playerId: String) async -> KinoaResponse? {
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/info")
            .setMethod(httpMethod: "DELETE")
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for deleting push personalization info")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func updateBadgeCounter(playerId: String, badgeCounterValue: Int) async -> KinoaResponse? {
        guard let identifierForVendor = UIDevice.current.identifierForVendor else {
            KinoaLogger.instance.LOG(message: "Device identifier not available")
            return nil
        }
        let deviceId = identifierForVendor.uuidString
        guard let webRoutes = SDK.instance.webRoutes else {
            KinoaLogger.instance.LOG(message: "Web routes not initialized")
            return nil
        }
        guard let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: webRoutes.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/\(deviceId)/badge-counter")
            .setMethod(httpMethod: "POST")
            .setPostData(KinoaBadgeCounterData(counterValue: badgeCounterValue))
            .buildAndAuthorize() else {
            KinoaLogger.instance.LOG(message: "Failed to build request for updating badge counter")
            return nil
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
}
