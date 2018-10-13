//
//  UILabel.swift
//  Hookers
//
//  Created by Kirill Sokolov on 10.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func addDefaultSoftShadow() {
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.9
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
    }
    
}
