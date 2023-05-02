//
//  BootBarnDemoApp.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/6/22.
//

import SwiftUI
import Firebase

@main
struct BootBarnDemoApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        if UserDefaults.standard.bool(forKey: "hasSeenHMLoading") {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            })
        }

        UserDefaults.standard.removeObject(forKey: "bagCount")

        return true

    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        print("didReceiveRemoteNotification: \(userInfo)")
        return .noData
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        if let fcmToken = fcmToken {

            print("didReceiveRegistrationToken: \(fcmToken)")
            Messaging.messaging().subscribe(toTopic: "default_audience_v2")
            Messaging.messaging().subscribe(toTopic: "os_ios")
            Messaging.messaging().subscribe(toTopic: "group_0")

            let LAST_TIMEZONE = "LAST_TIMEZONE"
            let currentTimezone = "\(TimeZone.current.secondsFromGMT())";
            if let lastTimezone = UserDefaults.standard.value(forKey: LAST_TIMEZONE) as? String {
                if currentTimezone != lastTimezone {
                    Messaging.messaging().unsubscribe(fromTopic: "timezone\(lastTimezone)");
                }
            }

            // iOS doesn't seem to be consistently unsubscribing from previous timezones,
            // so let's just unsubscribe from all of the common US timezones (excluding the current one).

            let commonTimezones:Array<String> = [
                "-36000",  // UTC -10
                "-32400",  // UTC -9
                "-28800",  // UTC -8
                "-25200",  // UTC -7
                "-21600",  // UTC -6
                "-18000",  // UTC -5
                "-16200",  // UTC -4.5
                "-14400",  // UTC -4
            ];

            for tz in commonTimezones {
                if tz != currentTimezone {
                    Messaging.messaging().unsubscribe(fromTopic: "timezone\(tz)");
                }
            }

            UserDefaults.standard.setValue(currentTimezone, forKey: LAST_TIMEZONE);
            Messaging.messaging().subscribe(toTopic: "timezone\(currentTimezone)");

        }

    }

}
