//
//  TabBarController.swift
//  Hookers
//
//  Created by Hookers on 5/29/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.5)
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage(color: UIColor.black.withAlphaComponent(0.8))
        tabBar.shadowImage = UIImage()
    }
    
    func configureTabs(with configuration: [(controller: UIViewController, tabItem: UITabBarItem)]) {
        let controllers = configuration.map { $0.controller }
        setViewControllers(controllers, animated: false)
        // We should set tabbarItems after setting controllers to allow changes to apply
        configuration.forEach { configuration in
            configuration.controller.tabBarItem = configuration.tabItem
            configuration.controller.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }
    
}
