//
//  OrdersListCoordinator.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class OrdersListCoordinator: TabBarEmbedCoordinator {
    
    fileprivate var root: UINavigationController!
    
    init(context: CoordinatingContext) {
        let servicesImage = UIImage(named: "services")
        let servicesActiveImage = UIImage(named: "services_active")
        
        let tabItemInfo = TabBarItemInfo(
            title: nil,
            icon: servicesImage,
            highlightedIcon: servicesActiveImage)
        
        super.init(context: context, tabItemInfo: tabItemInfo)
    }
    
    override func prepareForStart() {
        super.prepareForStart()
        
        let ordersList = UIStoryboard.OrdersList.ordersListViewController
        
        root = UINavigationController(rootViewController: ordersList)
    }
    
    override func createFlow() -> UIViewController {
        return root
    }
    
}
