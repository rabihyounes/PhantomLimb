//
//  ReminderHandler.swift
//  PhantomLimb
//
//  Created by xz353 on 3/21/24.
//

import Foundation
import UserNotifications

struct DateHelper {
    // The universally used DateFormatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

enum TherapyType: String {
    case Laterality = "Laterality Training"
    case Motor = "Motor Imagery Training"
    case Mirror = "Mirror Therapy"
}

struct NotificationManager {
    // Request user authorization for notifications
    static func requestNotificationAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("Notification authorization granted.")
                }
                else if let error = error {
                    print(error.localizedDescription)
                }
            }
    }

    static func getNotificationContent(therapyType: TherapyType) -> UNMutableNotificationContent {
        // Instantiate a variable for UNMutableNotificationContent
        let content = UNMutableNotificationContent()
        // The notification title
        content.title = "Now it's time for \(therapyType.rawValue)"
        switch therapyType {
            case .Laterality:
                content.body = "Take 5 minutes to complete your training."
            case .Motor:
                content.body = "You can take this training up to 2 hours."
            case .Mirror:
                content.body = "Enjoy your training!"
        }
        content.sound = .default
        return content
    }

    // Schedule daily notification at user-selected time
    static func scheduleNotification(therapyType: TherapyType, notificationTimeString: String) {
        // Convert the time in string to date
        guard let date = DateHelper.dateFormatter.date(from: notificationTimeString) else {
            return
        }

        let content = getNotificationContent(therapyType: therapyType)

        // Set the notification to repeat daily for the specified hour and minute
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // We need the identifier "journalReminder" so that we can cancel it later if needed
        // The identifier name could be anything, up to you
        let request = UNNotificationRequest(
            identifier: "\(therapyType.rawValue)&&\(notificationTimeString)",
            content: content,
            trigger: trigger
        )

        // Schedule the notification
        UNUserNotificationCenter.current().add(request)
    }

    // Cancel any scheduled notifications
    static func cancelNotification(therapyType: TherapyType, notificationTimeString: String) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["\(therapyType.rawValue)&&\(notificationTimeString)"])
    }
}
