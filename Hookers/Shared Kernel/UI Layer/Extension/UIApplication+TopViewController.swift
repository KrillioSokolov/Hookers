//
//  UIApplication+TopViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 06.03.2018.
//  Copyright © 2018 Hookers. All rights reserved.
//

import UIKit
import UserNotifications

extension UIApplication {
    
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = base as? UINavigationController, navigationController.viewControllers.count > 0 {
            return topViewController(navigationController.visibleViewController)
        }
        
        if let tabBarController = base as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presentedViewController = base?.presentedViewController {
            return topViewController(presentedViewController)
        }
        
        return base
    }
    
}

extension UIApplication {
    
    func registerNotifications() {
        let types: UIUserNotificationType = [.alert, .badge, .sound]
        
        if #available(iOS 10.0, *) {
            let options = types.authorizationOptions()
            UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        self.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: types, categories: nil)
            self.registerUserNotificationSettings(settings)
            self.registerForRemoteNotifications()
        }
    }
    
}

