//
//  AppDelegate.swift
//  notifyvisitors
//
//  Created by ashraf-nv on 12/14/2023.
//  Copyright (c) 2023 ashraf-nv. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Goto info.plist file of this sample app and replace values of 2 keys i.e. nvBrnadID and nvSecretKey with your account's credentials (brandID and secrect key) to get that login to your notifyvisitors account and goto Settings >> Store Integration
        
        // Notifyvisitors: Initialise the SDK
        var nvMode:String? = nil

         #if DEBUG
             nvMode = "debug"
         #else
             nvMode = "live"
        #endif
        notifyvisitors.initialize(nvMode)
        
       //Notifyvisitors: Push Notifications.
       //  To test push notification before going to further steps in your app or in this app you nee to goto our developer documentation (https://docs.notifyvisitors.com/docs/ios-push-notifications) under push notification section you nee to follow 1st step mention there under heading "Configure in NotifyVisitors Panel". After completing these steps you can go further to integrte in your app and test push notifications in your app.
        
        // Notifyvisitors: Register for Push notification (by calling this app will ask user permission to allow push notification on the user device)
        notifyvisitors.registerPush(withDelegate: self, app: application, launchOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // Notifyvisitors: If user click on "Allow" button when asked permission for push notifications then this delegate will called and a device token will be provided by os. By using the below method SDK will register the your current device token as subscription id in notifyvisitors panel.
        notifyvisitors.didRegisteredNotification(application, deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // Notifyvisitors: If user click on "Don't" Allow button when asked permission for push notifications then this delegate will called and the error description can be printed in logs to get the reason
     
        print("push registration failed due to the following error = \(error.localizedDescription)" )
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // Notifyvisitors: call applicationDidEnterBackground() method here
        notifyvisitors.applicationDidEnterBackground(application)
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        // Notifyvisitors: call applicationWillEnterForeground() method here
        notifyvisitors.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Notifyvisitors: call applicationDidBecomeActive() method here
        notifyvisitors.applicationDidBecomeActive(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        // Notifyvisitors: call applicationWillTerminate() method here
        notifyvisitors.applicationWillTerminate()
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
       
        // Notifyvisitors: call openUrl(with:url:) method here
        notifyvisitors.openUrl(with: app, url: url)
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
// Notifyvisitors: call didReceiveRemoteNotification(userInfo:fetchCompletionHandler:) method here
        notifyvisitors.didReceiveRemoteNotification(userInfo, fetchCompletionHandler:  completionHandler)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    //  Notifyvisitors: call willPresent(notification:withCompletionHandler:) method here it will called If your app is in the foreground when a notification arrives.
        notifyvisitors.willPresent(notification, withCompletionHandler: completionHandler)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //  Notifyvisitors: call didReceive(response:withCompletionHandler:) method here it will called when user click on received push notifications and using callback data you can perform redirection to you desired viewcontroller of your app.
        
        notifyvisitors.pushNotificationActionData(from: response, autoRedirectOtherApps: true) { (pushClickData: NSMutableDictionary?) in
            
            print("Notifyvisitors: pushClickData for further action = \(pushClickData ?? [:])")
            /* Here you will receive data which required to perform further action to redirect to further on push click you need to handle NavigateInApp condition when set from panel to redirect to a desired Viewcontroller based on target value to 0 as received in pushClickData variable if second parameter “autoRedirectOtherApps” value if false then you need to handle all actions on push click using pushClickData values and if it is true then you need to handle only target = 0 condition for NavigateInApp target */
            completionHandler()
        }
    }
}
