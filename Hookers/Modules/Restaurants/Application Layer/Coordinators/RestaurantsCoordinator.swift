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
        openRestaurantListViewController()
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
        
        restaurantStore.getRestaurantsList()
        
    }
    
}

//MARK: Open View Controllers
extension RestaurantsCoordinator {
    
    private func openRestaurantListViewController() {
        let restaurant = UIStoryboard.Restaurants.restaurantsListViewController
        
        restaurant.dispatcher = context.dispatcher
        restaurant.styleguide = context.styleguide
        
        root = UINavigationController(rootViewController: restaurant)
    }
    
    private func openRestaurantViewContoller(withRestaurantId restaurantId: String) {
        let controller = UIStoryboard.Restaurants.restaurantViewController
        
        controller.dispatcher = dispatcher
        controller.styleguide = context.styleguide
        
        root.tabBarController?.tabBar.isHidden = true
        
        if root.viewControllers[0].presentedViewController is UINavigationController {
            root.dismiss(animated: true, completion: nil)
            root.pushViewController(controller, animated: false)
        } else {
            root.pushViewController(controller, animated: true)
        }
    }
    
    private func openRestaurantInfoViewController(withRestaurantId restaurantId: String) {
        let controller = UIStoryboard.Restaurants.restaurantInfoViewController
        
        controller.dispatcher = dispatcher
        controller.styleguide = context.styleguide
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: controller)
        
        root.tabBarController?.tabBar.isHidden = true
        root.present(navBarOnModal, animated: true, completion: nil)
    }
    
}

//MARK: Register Events
extension RestaurantsCoordinator {
    
    private func register() {
        registerDidChooseRestaurant()
        registerCloseScreen()
        registerDidTapInfoButtonOnRestaurantCell()
    }
    
    private func registerDidChooseRestaurant() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self) { [weak self] result, _ in
            
            switch result {
            case .success(let box):
               self?.openRestaurantViewContoller(withRestaurantId: box.restaurantId)
            case .failure(_):
                break
            }
        }
    }
    
    private func registerDidTapInfoButtonOnRestaurantCell() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidTapInfoButtonOnRestaurantCell.self) { [weak self] result, _ in
            
            switch result {
            case .success(let box):
                self?.openRestaurantInfoViewController(withRestaurantId: box.restaurantId)
            case .failure(_):
                break
            }
        }
    }
    
    private func registerCloseScreen() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.CloseScreen.self) { [weak self] result, _ in
            switch result {
            case .success(let box):
            self?.root.tabBarController?.tabBar.isHidden = false
                
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
