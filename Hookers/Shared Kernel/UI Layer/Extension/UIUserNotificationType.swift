//
//  UIUserNotificationType.swift
//  Hookers
//
//  Created by Kirill Sokolov on 27.03.2018.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation
import UserNotificationsUI
import UserNotifications

extension UIUserNotificationType {
    
    @available(iOS 10.0, *)
    func authorizationOptions() -> UNAuthorizationOptions {
        var options: UNAuthorizationOptions = []
        if contains(.alert) {
            options.formUnion(.alert)
        }
        if contains(.sound) {
            options.formUnion(.sound)
        }
        if contains(.badge) {
            options.formUnion(.badge)
        }
        return options
    }
    
}

