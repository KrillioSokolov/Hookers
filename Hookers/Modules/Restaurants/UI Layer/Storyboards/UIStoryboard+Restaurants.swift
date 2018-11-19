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
    
    case datePickerViewController = "DatePickerViewControllerStoryboarId"
    case restaurantsListViewController = "RestaurantsListViewControllerStoryboarId"
    case restaurantInfoViewController = "RestaurantInfoViewControllerStoryboarId"
    case hookahMenuViewController = "HookahMenuViewControllerStoryboarId"
    case orderInfoViewController = "OrderInfoViewControllerStoryboardId"
    case confirmOrderViewController = "ConfirmOrderViewControllerStoryboardId"
    
}

extension UIStoryboard {
    
    static var restaurantsStoryboard: UIStoryboard {
        return UIStoryboard(name: "Restaurants", bundle: nil)
    }
    
    struct Restaurants {
        
        static var restaurantsListViewController: RestaurantsListViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.restaurantsListViewController.rawValue) as! RestaurantsListViewController
        }
        
        static var hookahMenuViewController: HookahMenuViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.hookahMenuViewController.rawValue) as! HookahMenuViewController
        }
        
        static var restaurantInfoViewController: RestaurantInfoViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.restaurantInfoViewController.rawValue) as! RestaurantInfoViewController
        }
        
        static var orderInfoViewController: OrderInfoViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.orderInfoViewController.rawValue) as! OrderInfoViewController
        }
        
        static var confirmOrderViewController: ConfirmOrderViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.confirmOrderViewController.rawValue) as! ConfirmOrderViewController
        }
        
        static var datePickerViewController: DatePickerViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.datePickerViewController.rawValue) as! DatePickerViewController
        }
        
    }
    
}
