//
//  UIImage.swift
//  Hookers
//
//  Created by Sokolov Kirill on 4/25/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import UIKit

import CoreGraphics

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
    }
    
    static func resizableImage(withColor color: UIColor) -> UIImage? {
        return UIImage(color: color)?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    }
    
    func renderingImage(withColor color: UIColor) -> UIImage? {
        let image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        return finalImage
    }
    
    static func renderImagesInCenter(_ images: [UIImage], colors: [UIColor?]) -> UIImage? {
        guard
            images.count == colors.count,
            let maxWidth = (images.map { $0.size.width }).max(),
            let maxHeight = (images.map { $0.size.height }).max(),
            let scale = images.first?.scale
            else { return nil }
        
        let size = CGSize(width: maxWidth, height: maxHeight)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        for (index, image) in images.enumerated() {
            let x = (maxWidth - image.size.width) / 2
            let y = (maxHeight - image.size.height) / 2
            let width = image.size.width
            let height = image .size.height
            
            var currentImage: UIImage!
            if let color = colors[index] {
                currentImage = image.withRenderingMode(.alwaysTemplate)
                color.set()
            } else {
                currentImage = image.withRenderingMode(.alwaysOriginal)
            }
            currentImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIImage {
    
    func overlayImage(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        color.setFill()
        
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        context!.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.draw(self.cgImage!, in: rect)
        
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.addRect(rect)
        context!.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage
    }
    
}
