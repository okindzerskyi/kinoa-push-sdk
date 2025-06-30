//
//  KinoaTokenRegistrationData.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

@available(macOS 13, *)
internal struct KinoaTokenRegistrationData: Codable {
    var languageCode: String?
    var deviceToken: String
    var deviceId: String?
    var platform: String
    var sdkVersion: String
    var provider: String
    var tokenGeneratedTs: Int64
    var lastLoginTs: Int64
    
    init(deviceToken: String, tokenGeneratedTs: Int64, lastLoginTs: Int64, deviceId: String?) {
        self.deviceId = deviceId
        self.platform = "IPhonePlayer"
        self.provider = "Apn"
        self.sdkVersion = "v1.10.0"
        self.languageCode = Locale.current.languageCode
        self.deviceToken = deviceToken;
        self.tokenGeneratedTs = tokenGeneratedTs
        self.lastLoginTs = lastLoginTs
    }
    
}

