//
//  AppDelegate.swift
//  Hookers
//
//  Created by Kirill Sokolov on 24.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(window: window!)
        
        return appCoordinator.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}

