//
//  KinoaNotificationManager.swift
//  
//
//  Created by user on 25.07.2023.
//

import Foundation
import UserNotifications

public class KinoaNotificationManager {
    private var contentHandler: ((UNNotificationContent) -> Void)?
    private var bestAttemptContent: UNMutableNotificationContent?
    
    public init() {
    }
    
    public func receivedNotification(
        request: UNNotificationRequest,
        contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        defer {
            contentHandler(bestAttemptContent ?? request.content)
        }

        guard let attachment = request.attachment else { return }

        bestAttemptContent?.attachments = [attachment]
    }
    
    public func bestAttempt() {
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
