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


extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, alpha: 1.0)
    }
    
    convenience init(greyTint: Int, alpha: CGFloat) {
        self.init(r: greyTint, g: greyTint, b: greyTint, alpha: alpha)
    }
    
    convenience init(greyTint: Int) {
        self.init(greyTint: greyTint, alpha: 1.0)
    }
    
    static func RGB(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
        return UIColor(r: r, g: g, b: b, alpha: 1.0)
    }
}
