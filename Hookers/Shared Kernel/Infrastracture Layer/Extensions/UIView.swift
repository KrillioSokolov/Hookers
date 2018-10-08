//
//  UIView.swift
//  Hookers
//
//  Created by Sokolov Kirill on 6/4/18.
//  Copyright © 2018 Приват24. All rights reserved.
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
