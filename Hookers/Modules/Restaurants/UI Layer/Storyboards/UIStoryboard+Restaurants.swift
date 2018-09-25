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
    
    case restaurants = "RestaurantsViewControllerStoryboarId"
    
}

extension UIStoryboard {
    
    static var restaurantsStoryboard: UIStoryboard {
        return UIStoryboard(name: "Restaurants", bundle: nil)
    }
    
    struct Restaurants {
        
        static var restaurantsViewController: RestaurantsViewController {
            return UIStoryboard.restaurantsStoryboard.instantiateViewController(withIdentifier: RestaurantsStoryboardControllerId.restaurants.rawValue) as! RestaurantsViewController
        }
        
    }
    
}
