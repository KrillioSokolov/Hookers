//
//  UIStoryboards+OrdersList.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum OrdersListStoryboardControllerId: String {
    
    case ordersList = "OrdersListViewControllerStoryboarId"
    case orderDetail = "OrderDetailViewControllerStoryboardId"
}

extension UIStoryboard {
    
    static var ordersListStoryboard: UIStoryboard {
        return UIStoryboard(name: "OrdersList", bundle: nil)
    }
    
    struct OrdersList {
        
        static var ordersListViewController: OrdersListViewController {
            return UIStoryboard.ordersListStoryboard.instantiateViewController(withIdentifier: OrdersListStoryboardControllerId.ordersList.rawValue) as! OrdersListViewController
        }
        
        static var orderDetailViewController: OrderDetailViewController {
            return UIStoryboard.ordersListStoryboard.instantiateViewController(withIdentifier: OrdersListStoryboardControllerId.orderDetail.rawValue) as! OrderDetailViewController
        }
        
    }
    
}
