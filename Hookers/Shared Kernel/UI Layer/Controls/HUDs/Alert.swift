//
//  Alert.swift
//  Hookers
//
//  Created by Sokolov Kirill on 5/26/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

enum AlertStyle {
    
    case error, success, info
    
}

protocol Alert {
    
    func show(on viewController: UIViewController,
              with style: AlertStyle,
              message: String,
              actionTitle: String?)
    
}
