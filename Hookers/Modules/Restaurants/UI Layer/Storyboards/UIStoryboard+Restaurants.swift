//
//  UIStoryboard+Restaurants.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum RestaurantsStoryboardControllerId: String {
    
    case restaurantsList = "RestaurantsListViewControllerStoryboarId"
    case restaurantInfo = "RestaurantInfoViewControllerStoryboarId"
    case restaurant = "RestaurantViewControllerStoryboarId"
    
}

extension UIStoryboard {
    
    static var restaurantsStoryboard: UIStoryboard {
        return UIStoryboard(name: "Restaurants", bundle: nil)
    }
    
    struct Restaurants {
        
        static var restaurantsListViewController: RestaurantsListViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.restaurantsList.rawValue) as! RestaurantsListViewController
        }
        
        static var restaurantViewController: RestaurantViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.restaurant.rawValue) as! RestaurantViewController
        }
        
        static var restaurantInfoViewController: RestaurantInfoViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.restaurantInfo.rawValue) as! RestaurantInfoViewController
        }
        
    }
    
}
