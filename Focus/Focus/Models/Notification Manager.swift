//
//  Notification Manager.swift
//  Focus
//
//  Created by Dmitry Gladilov on 25.04.2021.
//

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
    var body: String
    var timeInterval: Int
}

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    var notifications = [Notification]()
    
    var notificationCenter = UNUserNotificationCenter.current()
    
    func schedule() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
    
    private func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(notification.timeInterval), repeats: false)
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            notificationCenter.add(request) { error in
                guard error == nil else { return }
                print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
    
    func clearNotifications() {
        notifications.removeAll()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    
    func set(notification: Notification) {
        clearNotifications()
        notifications.append(notification)
        schedule()
    }
    
}
