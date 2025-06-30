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
    public static func calculateGameAuth(endpoint: String, request: URLRequest) -> String {
        let salt = SDK.instance.gameSecrets?.gameToken
        var valueForHash = endpoint
        if (request.httpBody != nil) {
            let requestBody = String(data: request.httpBody!, encoding: .utf8)
            valueForHash += requestBody!
        }
        let trimmedValueForHash = valueForHash.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let key = SymmetricKey(data: Data(salt!.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: Data(trimmedValueForHash.utf8), using: key)
        let stringSignature = Data(signature).map { String(format: "%02hhx", $0) }.joined()
        return stringSignature
    }
}
