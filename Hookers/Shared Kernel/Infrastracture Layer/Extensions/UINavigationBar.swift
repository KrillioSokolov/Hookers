//
//  UINavigationBar.swift
//  Hookers
//
//  Created by Sokolov Kirill on 4/16/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func addVisualEffectView() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let bounds = self.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
        visualEffectView.frame = bounds
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.layer.zPosition = -1
        
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .default)
        self.addSubview(visualEffectView)
    }
        
}

extension UINavigationItem {
    
    @discardableResult
    func addBackButton(with target: Any?, action: Selector, tintColor: UIColor? = nil) -> UIBarButtonItem {
        let backButton = UIButton()
        let image = UIImage(named: "back_button")?.withRenderingMode(.alwaysTemplate)
        let barButtonItem = UIBarButtonItem(customView: backButton)
        
        backButton.setImage(image, for: .normal)
        backButton.tintColor = tintColor
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backButton.addTarget(target, action: action, for: .touchUpInside)
        var contentInsets = backButton.contentEdgeInsets
        contentInsets.left = -30
        backButton.contentEdgeInsets = contentInsets
        setLeftBarButton( barButtonItem, animated: true)
        
        return barButtonItem
    }
    
    func addCloseButton(with target: Any?, action: Selector, tintColor: UIColor? = nil) {
        let closeButton = UIButton()
        let image = UIImage(named: "btNavBarClose")?.withRenderingMode(.alwaysTemplate)
        
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = tintColor
        closeButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        closeButton.addTarget(target, action: action, for: .touchUpInside)
        var contentInsets = closeButton.contentEdgeInsets
        contentInsets.left = -30
        closeButton.contentEdgeInsets = contentInsets
        setLeftBarButton(UIBarButtonItem(customView: closeButton), animated: true)
    }
    
}
