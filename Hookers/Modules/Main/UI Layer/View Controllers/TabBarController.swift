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
        tabBar.isTranslucent = true
        tabBar.alpha = 0.8
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

extension UITabBarController {
    
    func setPhoneTabBarVisible(visible: Bool, animated: Bool) {
        guard !UIDevice.isPad() else { return }
        guard (tabBarIsVisible() != visible) else { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
                self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
                self.view.setNeedsDisplay()
                self.view.layoutIfNeeded()
                }.startAnimation()
        } else {
            self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
    
    func tabBarIsVisible() -> Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}

