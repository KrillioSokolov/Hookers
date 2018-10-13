//
//  CALayer.swift
//  Hookers
//
//  Created by Sokolov Kirill on 4/16/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import UIKit

extension CALayer {
    
    func applyShadow(color: UIColor = .black, alpha: Float = 0.1, x: CGFloat = 0, y: CGFloat = 3, blur: CGFloat = 30,
                     spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}
