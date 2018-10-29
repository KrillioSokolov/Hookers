//
//  Spinner.swift
//  Hookers
//
//  Created by Sokolov Kirill on 5/26/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

protocol Spinner {
    
    func show(on view: UIView, text: String?, animated: Bool, blockUI: Bool)
    func hide(from view: UIView, animated: Bool)
    
}
