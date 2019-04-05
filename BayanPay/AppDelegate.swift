//
//  AppDelegate.swift
//  Paypal
//
//  Created by Suzan Amassy on 3/30/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import BRYXBanner

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate {

    var window: UIWindow?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true

        if let userName = Services.lunched(){
            let wind = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "TbBarVS")
            window?.rootViewController = wind
        } else {

            let wind = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "StoryboardVC")
            window?.rootViewController = wind
        }
        setupRemoteNotifications(application)
        return true
        
    }
    
    func setupRemoteNotifications(_ application: UIApplication){
        
        //        Messaging.messaging().delegate = self
        //UNUserNotificationCenter.current().delegate = self
        //
        let application = UIApplication.shared
        if !application.isRegisteredForRemoteNotifications {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions,completionHandler: {_, _ in })
            
            application.registerForRemoteNotifications()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

 @available(iOS 10, *)
 extension AppDelegate : UNUserNotificationCenterDelegate {
 
 func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
 }
 
 
 func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
 fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
 completionHandler(UIBackgroundFetchResult.newData)
 }
 
 func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { }
 
 func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
 Messaging.messaging().apnsToken = deviceToken
 }
    
    
 
 
 func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
 
 if let refreshedToken = InstanceID.instanceID().token() {
// if Auth_User.User_Id != 0 {
// Auth_User.User_Token = refreshedToken
// //Auth_User.func_updateDeviceTokenForFirebase(refreshedToken)
// }
 }
 connectToFcm()
 }
 
 func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) { }
 
 func connectToFcm() {
 guard InstanceID.instanceID().token() != nil else {
 return;
 }
 Messaging.messaging().shouldEstablishDirectChannel = true
 }
 
 // Receive displayed notifications for iOS 10 devices.
 func userNotificationCenter(_ center: UNUserNotificationCenter,
 willPresent notification: UNNotification,
 withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 
 
 let userInfo = notification.request.content.userInfo
 
 //clicked
 
 let state = UIApplication.shared.applicationState
 // id user save local in app
    //Banner library use to show alert
    
    
 if state == .active  &&  Services.getApiTell() !=  "" {
 if let aps = userInfo["aps"] as? [String:Any] {
 if let alert = aps["alert"] as? [String:Any] {
 let body = alert["body"] as? String ?? ""
 let title = alert["title"] as? String ?? ""
 let banner = Banner(title: title, subtitle:body, image: UIImage(named: "mail"), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
    banner.dismissesOnTap = true
    banner.show(duration: 6.0)

 banner.didTapBlock = {}
    
}
}}


 
 /////
 func userNotificationCenter(_ center: UNUserNotificationCenter,
 didReceive response: UNNotificationResponse,
 withCompletionHandler completionHandler: @escaping () -> Void) {
 
 //clicked
 let userInfo = response.notification.request.content.userInfo
 
 let state = UIApplication.shared.applicationState
// if (state == .inactive || state == .background)  && Auth_User.User_Id != 0 {
// self.func_updatePadgeActive(userInfo)
// Auth_User.func_goToApp()
// }
 }
 
 
 
 
    }

 

}
