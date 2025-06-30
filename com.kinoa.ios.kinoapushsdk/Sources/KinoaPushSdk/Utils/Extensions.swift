//
//  Extensions.swift
//  
//
//  Created by user on 24.07.2023.
//

import Foundation
import UserNotifications
import UIKit

internal extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

class Preferences {
    static func get<T>(defaultValue: T, forKey key: String) -> T {
        let preferences = UserDefaults.standard
        guard let object = preferences.object(forKey: key) else {
            return defaultValue
        }
        guard let result = object as? T else {
            return defaultValue
        }
        return result
    }

    static func set(value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

internal extension UNNotificationRequest {
    var attachment: UNNotificationAttachment? {
        guard let attachmentURL = content.userInfo["imageUrl"] as? String,
              let url = URL(string: attachmentURL),
              let imageData = try? Data(contentsOf: url) else {
            return nil
        }
        return try? UNNotificationAttachment(data: imageData, options: nil)
    }
}

internal extension UNNotificationAttachment {

    convenience init(data: Data, options: [NSObject: AnyObject]?) throws {
        let fileManager = FileManager.default
        let temporaryFolderName = ProcessInfo.processInfo.globallyUniqueString
        let temporaryFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(temporaryFolderName, isDirectory: true)

        try fileManager.createDirectory(at: temporaryFolderURL, withIntermediateDirectories: true, attributes: nil)
        let imageFileIdentifier = UUID().uuidString + ".png";
        let fileURL = temporaryFolderURL.appendingPathComponent(imageFileIdentifier)
        try data.write(to: fileURL)
        try self.init(identifier: imageFileIdentifier, url: fileURL, options: options)
    }
}

public extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
