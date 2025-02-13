//
//  SceneDelegate.swift
//  Notifications
//
//  Created by 이상민 on 2/13/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = NotificationViewController()
        window?.makeKeyAndVisible()
    }

    //date -> badge -> badege 추가 -> 삭제 -> pendiremoveall
    func sceneDidDisconnect(_ scene: UIScene) {
        //Badge 제거
        //iOS 17.0
//        UIApplication.shared.applicationIconBadgeNumber = 0
        //iOS 18.0+
        UNUserNotificationCenter.current().setBadgeCount(0)
        
        //사용자에게 전달되어 있는 알람 제거 (default로는 알람을 클릭해서 열어주어야 그 알람만 제거됨!)
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        //사용자에게 아직 전달되지 않았지만, 앞으로 전달될 알람을 제거
//        UNUserNotificationCenter
//            .current()
//            .removeAllPendingNotificationRequests()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

