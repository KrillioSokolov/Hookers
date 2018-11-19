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
    fileprivate var restaurantStore: RestaurantStore!
    
    private var dispatcher: Dispatcher {
        return context.dispatcher
    }
    
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
        
        makeRestaurantStore()
        openDatePickerViewController()
        register()
    }
    
    override func createFlow() -> UIViewController {
        return root
    }
    
}

extension RestaurantsCoordinator {
    
    func makeRestaurantStore() {
        let restaurantNetwork = RestaurantNetworkService(networkService: context.networkService)
        
        restaurantStore = RestaurantStore(networkService: restaurantNetwork, dispatcher: context.dispatcher)
    }
    
}

//MARK: Open View Controllers
extension RestaurantsCoordinator {
    
    private func openDatePickerViewController() {
        let controller = UIStoryboard.Restaurants.datePickerViewController
        
        controller.dispatcher = context.dispatcher
        controller.styleguide = context.styleguide
        controller.restaurantStore = restaurantStore
        
        root = UINavigationController(rootViewController: controller)
    }
    
    private func openRestaurantListViewController(animated: Bool) {
        let controller = UIStoryboard.Restaurants.restaurantsListViewController
        
        controller.dispatcher = context.dispatcher
        controller.styleguide = context.styleguide
        controller.restaurantStore = restaurantStore
        
        root.pushViewController(controller, animated: animated)
    }
    
    private func openRestaurantViewContoller(with restaurant: DisplayableRestaurantListItem) {
        let controller = UIStoryboard.Restaurants.hookahMenuViewController
        
        controller.dispatcher = dispatcher
        controller.styleguide = context.styleguide
        controller.restaurantStore = restaurantStore
        controller.restaurantListItem = restaurant
        
        root.tabBarController?.tabBar.isHidden = true
        
        if root.viewControllers[0].presentedViewController is UINavigationController {
            root.dismiss(animated: true, completion: nil)
            root.pushViewController(controller, animated: false)
        } else {
            root.pushViewController(controller, animated: true)
        }
    }
    
    private func openRestaurantInfoViewController(with restaurant: NetworkRestaurant) {
        let controller = UIStoryboard.Restaurants.restaurantInfoViewController
        
        controller.dispatcher = dispatcher
        controller.styleguide = context.styleguide
        controller.restaurant = restaurant
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: controller)
        
        root.tabBarController?.tabBar.isHidden = true
        root.present(navBarOnModal, animated: true, completion: nil)
    }
    
    private func openOrderInfoViewController(with restaurant: DisplayableRestaurantListItem, mixesForOrder: [HookahMix]) {
        let controller = UIStoryboard.Restaurants.orderInfoViewController
        
        controller.dispatcher = dispatcher
        controller.styleguide = context.styleguide
        controller.restaurantListItem = restaurant
        controller.restaurantStore = restaurantStore
        controller.mixesForOrder = mixesForOrder
        
        root.tabBarController?.tabBar.isHidden = true
        root.pushViewController(controller, animated: true)
    }
    
}

//MARK: Register Events
extension RestaurantsCoordinator {
    
    private func register() {
        registerDidSelectDueDate()
        registerDidChooseRestaurant()
        registerCloseScreen()
        registerDidTapInfoButtonOnRestaurantCell()
        registerDidChooseMixesForOrder()
    }
    
    private func registerDidChooseRestaurant() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self) { [weak self] result, _ in
            
            switch result {
            case .success(let box):
               self?.openRestaurantViewContoller(with: box.restaurant)
            case .failure(_):
                break
            }
        }
    }
    
    private func registerDidTapInfoButtonOnRestaurantCell() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidTapInfoButtonOnRestaurantCell.self) { [weak self] result, _ in
            
            switch result {
            case .success(let box):
                self?.openRestaurantInfoViewController(with: box.restaurant)
            case .failure(_):
                break
            }
        }
    }
    
    private func registerDidChooseMixesForOrder() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidChooseMixesForOrder.self) { [weak self] result, _ in
            switch result {
            case .success(let box):
                self?.openOrderInfoViewController(with: box.restaurant, mixesForOrder: box.mixesForOrder)
            case .failure(_):
                break
            }
        }
    }
    
    private func registerDidSelectDueDate() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidSelectDueDate.self) { [weak self] result, _ in
            switch result {
            case .success(let box):
                self?.openRestaurantListViewController(animated: box.animated)
            case .failure(_):
                break
            }
        }
    }
    
    private func registerCloseScreen() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.CloseScreen.self) { [weak self] result, _ in
            switch result {
            case .success(let box):
            if self?.root.presentedViewController != nil {
                self?.root.dismiss(animated: box.animated, completion: nil)
            } else {
                self?.root.popViewController(animated: true)
            }
            case .failure(_):
                break
            }
        }
    }
    
}
