//
//  RestaurantsCoordinator.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class RestaurantsCoordinator: TabBarEmbedCoordinator {

    fileprivate var root: UINavigationController!
    
    init(context: CoordinatingContext) {
        let homeImage = UIImage(named: "home")
        let homeImageActive = UIImage(named: "home_active")
        let tabItemInfo = TabBarItemInfo(
            title: nil,
            icon: homeImage,
            highlightedIcon: homeImageActive)
        
        super.init(context: context, tabItemInfo: tabItemInfo)
    }
    
    override func prepareForStart() {
        super.prepareForStart()
        
        let restaurants = UIStoryboard.Restaurants.restaurantsViewController
        restaurants.view.backgroundColor = .cyan
        
        root = UINavigationController(rootViewController: restaurants)
    }
    
    override func createFlow() -> UIViewController {
        return root
    }
    
}
