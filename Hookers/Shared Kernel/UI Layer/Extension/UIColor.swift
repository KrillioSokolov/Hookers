//
//  UIColor.swift
//  Hookers
//
//  Created by Sokolov Kirill on 4/25/18.
//  Copyright © 2018 Hookers. All rights reserved.
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

public extension UIColor {
    
    /*
     Функция анализирует цвет и если цвет темный то возвращает UIColor.white; если цвет светлый то возвращает UIColor.black.
     Альфа-канал не используется при анализе, поэтому для корректрного результата нужно использовать цвет без альфа-канала.
     Если у цвета есть альфа-канал, то его можно убрать, например, используя функции solidRGBAboveBlackColor и solidRGBAboveWhiteColor
     */
    
    public func contrastBlackOrWhite() -> UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        r = r * 255
        g = g * 255
        b = b * 255
        
        let yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        return (yiq >= 186) ? .black : .white
    }
    
    /*
     Функция берет цвет color, в котором есть alpha, накладывает его поверх bgColor без alpha и возвращает результат без alpha
     https://stackoverflow.com/a/36089930/759685
     */
    
    public static func solidRGB(fromRGBAColor color: UIColor, aboveBackgroundColor bgColor: UIColor) -> UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        r = r * 255
        g = g * 255
        b = b * 255
        a = a * 255
        
        var bgR: CGFloat = 0, bgG: CGFloat = 0, bgB: CGFloat = 0
        bgColor.getRed(&bgR, green: &bgG, blue: &bgB, alpha: nil)
        
        bgR = bgR * 255
        bgG = bgG * 255
        bgB = bgB * 255
        
        let alpha = a / 255;
        let oneminusalpha = 1 - alpha;
        
        let newR = floor(((r * alpha) + (oneminusalpha * bgR)))
        let newG = floor(((g * alpha) + (oneminusalpha * bgG)))
        let newB = floor(((b * alpha) + (oneminusalpha * bgB)))
        
        return UIColor(r: Int(newR), g: Int(newG), b: Int(newB))
    }
    
    public var solidRGBAboveBlackColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: self, aboveBackgroundColor: .black)
    }
    
    public var solidRGBAboveWhiteColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: self, aboveBackgroundColor: .white)
    }
    
}

