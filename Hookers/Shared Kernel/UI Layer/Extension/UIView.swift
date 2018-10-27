//
//  UIView.swift
//  Hookers
//
//  Created by Sokolov Kirill on 6/4/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import UIKit

extension UIView {
    
    func viewFromNib(nibName: String? = nil) -> UIView {
        let name = nibName ?? String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle).instantiate(withOwner: self, options: nil)
        let nibView = nib.first as! UIView
        nibView.translatesAutoresizingMaskIntoConstraints = false
        
        return nibView
    }
    
}

extension UIView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    func addDefaultShadow() {
        self.layer.shadowColor = UIColor(r: 80, g: 80, b: 80, alpha: 10).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIView {
    
    @discardableResult static func instantiateFromNib() -> Self {
        return instantiateViewFromNib(viewType: self)
    }
    
    private static func instantiateViewFromNib<T: UIView>(viewType: T.Type) -> T! {
        return Bundle.main.loadNibNamed(
            String(describing: viewType),
            owner: nil,
            options: nil)?.first as! T
    }
    
    static func loadNib<T: UIView>(viewType: T.Type, owner: T) {
        Bundle.main.loadNibNamed(String(describing: viewType),
                                 owner: owner,
                                 options: nil)
    }
    
}
