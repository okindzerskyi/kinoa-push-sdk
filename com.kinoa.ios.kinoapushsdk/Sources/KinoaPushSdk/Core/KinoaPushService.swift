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
        let deviceId = await UIDevice.current.identifierForVendor!.uuidString
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices")
            .setMethod(httpMethod: "POST")
            .setPostData(KinoaTokenRegistrationData(
                            deviceToken: deviceToken,
                            tokenGeneratedTs: tokenGeneratedTs,
                            lastLoginTs: lastLoginTs,
                            deviceId: deviceId))
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func deleteToken(playerId: String, deviceToken: String) async -> KinoaResponse? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices")
            .setMethod(httpMethod: "DELETE")
            .addParameter(key: "deviceToken", value: deviceToken)
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func blockPushes(playerId: String) async -> KinoaResponse? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/block")
            .setMethod(httpMethod: "POST")
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func unblockPushes(playerId: String) async -> KinoaResponse? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/unblock")
            .setMethod(httpMethod: "POST")
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func getPushesStatus(playerId: String) async -> KinoaResponseT<KinoaPushesStatus>? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/blocked")
            .setMethod(httpMethod: "GET")
            .buildAndAuthorize();
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponseT(
                KinoaPushesStatus.self, data: data, response: response)
        }
        catch {}
        return nil
    }
    
    public func updatePushClickAnalytic(playerId: String, pushClickAnalyticData: KinoaPushClickAnalyticData) async -> KinoaResponse? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/analytic/click")
            .setMethod(httpMethod: "POST")
            .setPostData(pushClickAnalyticData)
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func setPushPersonalizationInfo(playerId: String, pushPersonalizationInfo: KinoaPushPersonalizationInfo) async -> KinoaResponse? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/info")
            .setMethod(httpMethod: "POST")
            .setPostData(pushPersonalizationInfo)
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func getPushPersonalizationInfo(playerId: String) async -> KinoaResponseT<KinoaPushPersonalizationInfo>? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/info")
            .setMethod(httpMethod: "GET")
            .buildAndAuthorize();
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponseT(
                KinoaPushPersonalizationInfo.self, data: data, response: response)
        }
        catch {}
        return nil
    }
    
    public func deletePushPersonalizationInfo(playerId: String) async -> KinoaResponse? {
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/info")
            .setMethod(httpMethod: "DELETE")
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
    public func updateBadgeCounter(playerId: String, badgeCounterValue: Int) async -> KinoaResponse? {
        let deviceId = await UIDevice.current.identifierForVendor!.uuidString
        let request = KinoaRequestBuilder()
            .setBaseUrl(baseUrl: SDK.instance.webRoutes!.pushServiceUrl)
            .setEndpoint(endpoint: "/player/\(playerId)/devices/\(deviceId)/badge-counter")
            .setMethod(httpMethod: "POST")
            .setPostData(KinoaBadgeCounterData(counterValue: badgeCounterValue))
            .buildAndAuthorize();
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return KinoaResponseBuilder.buildResponse(response: response)
        }
        catch {}
        return nil
    }
    
}
