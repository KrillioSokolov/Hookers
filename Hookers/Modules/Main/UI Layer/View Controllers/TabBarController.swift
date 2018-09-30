//
//  TabBarController.swift
//  Privat24
//
//  Created by Roman Scherbakov on 5/29/17.
//  Copyright © 2017 Privat24. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor.clear
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
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
