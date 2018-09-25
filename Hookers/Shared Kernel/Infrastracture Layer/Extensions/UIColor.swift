//
//  UIColor.swift
//  Hookers
//
//  Created by Sokolov Kirill on 4/25/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import UIKit

extension UIColor {
    
    func getRGBAComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var (red, green, blue, alpha) = (CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0))
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red, green, blue, alpha)
        }

        return nil
    }
    
}
