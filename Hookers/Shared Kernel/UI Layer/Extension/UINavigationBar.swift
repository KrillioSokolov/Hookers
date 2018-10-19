//
//  UINavigationBar.swift
//  Hookers
//
//  Created by Sokolov Kirill on 4/16/18.
//  Copyright © 2018 Hookers. All rights reserved.
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
    
    func setTitleView(withTitle title: String, subtitle: String = "", titleColor: UIColor, titleFont: UIFont, subtitleColor: UIColor, subtitleFont: UIFont) {
        let titleAttributes = [NSAttributedStringKey.foregroundColor: titleColor, NSAttributedStringKey.font: titleFont]
        var titleString = NSMutableAttributedString()
        
        if subtitle.length == 0 {
            titleString = NSMutableAttributedString(string: title, attributes: titleAttributes)
        } else {
            titleString = NSMutableAttributedString(string: title + "\n", attributes: titleAttributes)
            let subtitleAttribute = [NSAttributedStringKey.foregroundColor: subtitleColor , NSAttributedStringKey.font: subtitleFont]
            let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttribute)
            titleString.append(subtitleString)
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: titleString.size().width, height: 44))
        
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.attributedText = titleString
        
        self.titleView = label
        slowAppearAnimation(view: self.titleView)
    }
    
    func addCloseButton(with target: Any?, action: Selector, tintColor: UIColor? = nil) {
        let closeButton = UIButton()
        let image = UIImage(named: "btNavBarClose")?.withRenderingMode(.alwaysTemplate)
        
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = tintColor ?? .purple
        closeButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        closeButton.addTarget(target, action: action, for: .touchUpInside)
        var contentInsets = closeButton.contentEdgeInsets
        contentInsets.left = -30
        closeButton.contentEdgeInsets = contentInsets
        setLeftBarButton(UIBarButtonItem(customView: closeButton), animated: true)
    }
    
}

func slowAppearAnimation(view: UIView?) {
    view?.alpha = 0
    
    if #available(iOS 11.0, *) {
        UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            view?.alpha = 1.0
            }.startAnimation()
        
    } else {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [] ,
                       animations: {
                        view?.alpha = 1.0
        })
    }
}

