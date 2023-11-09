//
//  AppDelegate.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit
import FirebaseMessaging
import AppTrackingTransparency
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseManager.instance.configure()
        FirebaseManager.instance.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        self.permissions()

        return true
    }

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("FCMToken: \(token)")
        FirebaseManager.instance.messaging().apnsToken = deviceToken
    }

}

extension AppDelegate : UNUserNotificationCenterDelegate, MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            print("FCMToken\(token)")
        } else {
            print("FCMToken alınamadı.")
        }
    }
}

extension AppDelegate {
    private func permissions() {
        self.notificationPermission {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.ATTracking()
            }
        }
    }
    
    private func notificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { status, _ in
                if(status) {
                    self.getNotificationSettings()
                }
                completion()
            }
    }
    
    private func ATTracking() {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("ATT: authorized")
                case .denied:
                    print("ATT: denied")
                case .notDetermined:
                    print("ATT: notDetermined")
                case .restricted:
                    print("ATT: restricted")
                @unknown default:
                    print("ATT: unknown")
                }
            }
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

