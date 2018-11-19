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
    fileprivate var ordersStore: OrdersListStore!
    
    private var dispatcher: Dispatcher {
        return context.dispatcher
    }
    
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
        
        makeOrdersStore()
        openOrdersListViewController()
        register()
    }
    
    override func createFlow() -> UIViewController {
        return root
    }
    
}

extension OrdersListCoordinator {
    
    func makeOrdersStore() {
        let restaurantNetwork = OrdersNetworkService(networkService: context.networkService)
        
        ordersStore = OrdersListStore(networkService: restaurantNetwork, dispatcher: context.dispatcher)
    }
    
}

//MARK: Open View Controllers
extension OrdersListCoordinator {
    
    private func openOrdersListViewController() {
        let ordersListViewController = UIStoryboard.OrdersList.ordersListViewController
        
        ordersListViewController.dispatcher = context.dispatcher
        ordersListViewController.styleguide = context.styleguide
        ordersListViewController.ordersListStore = ordersStore
        
        root = UINavigationController(rootViewController: ordersListViewController)
    }
    

    
    
}

//MARK: Register Events
extension OrdersListCoordinator {
    
    private func register() {
        registerDidChooseOrder()
    }
    
    //CS: TODO:
    private func registerDidChooseOrder() {
//        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self) { [weak self] result, _ in
//
//            switch result {
//            case .success(let box):
//                break
////                self?.openRestaurantViewContoller(withRestaurantId: box.restaurantId)
//            case .failure(_):
//                break
//            }
//        }
    }

}


