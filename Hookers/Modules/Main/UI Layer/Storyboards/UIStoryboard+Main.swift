//
//  UIStoryboard+Main.swift
//  Hookers
//
//  Created by Hookers on 5/29/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

fileprivate enum TabBarStoryboardControllerID: String {
    
    case tabBar = "TabBarControllerStoryboardID"
    
}

extension UIStoryboard {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    struct TabBar {
    
        static var tabBarViewController: TabBarController {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: TabBarStoryboardControllerID.tabBar.rawValue)
            return vc as! TabBarController
        }

    }
    
}
