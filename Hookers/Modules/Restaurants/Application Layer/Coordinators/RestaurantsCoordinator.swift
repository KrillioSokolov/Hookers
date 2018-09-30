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
        
        let restaurant = UIStoryboard.Restaurants.restaurantsListViewController
        
        restaurant.dispatcher = context.dispatcher
        restaurant.view.backgroundColor = .black
        
        register()
        
        root = UINavigationController(rootViewController: restaurant)
    }
    
    override func createFlow() -> UIViewController {
        return root
    }
    
}

//MARK: Register Events
extension RestaurantsCoordinator {
    
    private func register() {
        registerDidChooseRestaurant()
        registerCloseScreen()
    }
    
    private func registerDidChooseRestaurant() {
        dispatcher.register(type: RestaurantsEvent.NavigationEvent.DidChooseRestaurant.self) { [weak self] result, _ in
            
            switch result {
            case .success(let box):
                _ =  box.restaurantId
                
                let controller = UIStoryboard.Restaurants.restaurantViewController
                
                controller.dispatcher = self?.dispatcher
                
                self?.root.tabBarController?.tabBar.isHidden = true
                self?.root.pushViewController(controller, animated: true)
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
