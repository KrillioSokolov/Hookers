//
//  AppCoordinator.swift
//  Hookers
//
//  Created by Kirill Sokolov on 24.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit
import Alamofire

final class AppCoordinator: Coordinator {

    private(set) unowned var window: UIWindow
    private var root: UINavigationController!
    
    // coordinators
    private var tabBarCoordinator: TabBarCoordinator!
    private var restaurantCoordinator: RestaurantsCoordinator!
    private var ordersListCoordinator: OrdersListCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        
        super.init(context: CoordinatingContext())
    }
    
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        prepareForStart()
        setupRootViewController()
        
        return true
    }
    
    override func prepareForStart() {
        super.prepareForStart()
    }

    private func setupRootViewController() {
        tabBarCoordinator = TabBarCoordinator(context: context)
        tabBarCoordinator.prepareForStart()
        
        restaurantCoordinator = RestaurantsCoordinator(context: context)
        restaurantCoordinator.prepareForStart()
        
        ordersListCoordinator = OrdersListCoordinator(context: context)
        ordersListCoordinator.prepareForStart()
        
        tabBarCoordinator.addTabCoordinators(coordinators: [restaurantCoordinator, ordersListCoordinator])
        
        let rootViewController = tabBarCoordinator.createFlow()
        
        window.rootViewController = rootViewController
    }
    
    private func configurateTabBarController() {
        
    }
    
}
