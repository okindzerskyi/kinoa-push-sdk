//
//  KinoaGameAuthUtils.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation
import CryptoKit

@available(iOS 13.0, *)
internal class KinoaGameAuthUtils {
    public static func calculateGameAuth(endpoint: String, request: URLRequest) -> String? {
        guard let salt = SDK.instance.gameSecrets?.gameToken else {
            KinoaLogger.instance.LOG(message: "Game token not available")
            return nil
        }
        var valueForHash = endpoint
        if let httpBody = request.httpBody {
            if let requestBody = String(data: httpBody, encoding: .utf8) {
                valueForHash += requestBody
            }
        }
        let trimmedValueForHash = valueForHash.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let key = SymmetricKey(data: Data(salt.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: Data(trimmedValueForHash.utf8), using: key)
        let stringSignature = Data(signature).map { String(format: "%02hhx", $0) }.joined()
        return stringSignature
    }
}
