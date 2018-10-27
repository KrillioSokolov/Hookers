//
//  TabBarCoordinator.swift
//  Hookers
//
//  Created by Hookers on 5/29/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinator {
    
    fileprivate var root: TabBarController!
    
    override func prepareForStart() {
        super.prepareForStart()
        
        root = makeTabBarController()
    }
    
    override func createFlow() -> UIViewController {
        return root
    }
    
    func addTabCoordinators(coordinators: [TabBarEmbedCoordinator]) {
        var controllers = [UIViewController]()
        var tabItemMap = [(controller: UIViewController, tabItem: UITabBarItem)]()
        for coordinator in coordinators {
            let controller = coordinator.createFlow()
            let tabItem = coordinator.tabItem()
            tabItemMap.append((controller: controller, tabItem: tabItem))
            controllers.append(controller)
        }
        
        root.configureTabs(with: tabItemMap)
    }
    
    private func makeTabBarController() -> TabBarController {
        let tabBarController = UIStoryboard.TabBar.tabBarViewController

        return tabBarController
    }
    
}

