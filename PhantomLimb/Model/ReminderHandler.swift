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

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    private(set) var notification_denied: Bool = false
    //Handle with notification when the app is running foreground
    
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) ->
            Void
    ) {
        let id = notification.request.identifier
        print("In App: Notification ID = \(id)")
        completionHandler([.banner, .sound])
    }

    //Handle with notificaiton when the app is at background
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let id = response.notification.request.identifier
        print("Background: Notification ID = \(id)")
        completionHandler()
    }

    // Request user authorization for notifications
    func requestNotificationAuthorization() {
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

    private func getNotificationContent(
        therapyType: TherapyType
    ) -> UNMutableNotificationContent {
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
    func scheduleNotification(therapyType: TherapyType, notificationTimeString: String) {
        // Schedule the notification
        UNUserNotificationCenter.current()
            .getNotificationSettings { [weak self] settings in
                guard let strongSelf = self else { return }
                switch settings.authorizationStatus {
                    case .authorized, .provisional:
                        let request = strongSelf.prepareNotification(
                            therapyType: therapyType,
                            notificationTimeString: notificationTimeString
                        )
                        UNUserNotificationCenter.current().add(request)
                        print("\(request.identifier) added")
                    case .notDetermined:
                        strongSelf.requestNotificationAuthorization()
                    case .denied:
                        strongSelf.notification_denied = true
                    default:
                        break
                }
            }
    }

    private func prepareNotification(
        therapyType: TherapyType,
        notificationTimeString: String
    ) -> UNNotificationRequest {
        // Convert the time in string to date
        let date = DateHelper.dateFormatter.date(from: notificationTimeString)

        let content = getNotificationContent(therapyType: therapyType)

        // Set the notification to repeat daily for the specified hour and minute
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // We need the identifier so that we can cancel it later if needed
        let request = UNNotificationRequest(
            identifier: "\(therapyType.rawValue)&&\(notificationTimeString)",
            content: content,
            trigger: trigger
        )
        return request
    }

    // Cancel any scheduled notifications
    func cancelNotification(therapyType: TherapyType, notificationTimeString: String) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [
                "\(therapyType.rawValue)&&\(notificationTimeString)"
            ])
        print("\(therapyType.rawValue)&&\(notificationTimeString) cancelled")
    }
}
