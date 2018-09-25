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
