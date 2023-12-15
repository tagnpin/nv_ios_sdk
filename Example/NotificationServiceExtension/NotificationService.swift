//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Notifyvisitors Macbook Air 4 on 15/12/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
        // Notifyvisitors: call loadAttachment(with::bestAttempt:withContentHandler:) method here it will called when Notification Service extension triggeed when a push arrives before a visible push shown on your device in background and it will download if any rich media comtent (i.e. image, audio or video) present in the notifyvisitors push payload. Note that it will call only for a very short period oftime (for some seconds only) if the rich media content download not completed within this time due to any cause like slow internet speed then the push will be deliverd with text only on your device.
            
            notifyvisitors.loadAttachment(with: request, bestAttempt: bestAttemptContent, withContentHandler: self.contentHandler)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
