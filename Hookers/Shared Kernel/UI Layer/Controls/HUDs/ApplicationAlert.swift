//
//  ApplicationAlert.swift
//  Hookers
//
//  Created by Sokolov Kirill on 5/26/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import MBProgressHUD

//ML: TODO: refactor spinners and alerts later

final class ApplicationAlert: Alert {
    
    func show(on viewController: UIViewController, with style: AlertStyle, message: String,
              actionTitle: String?) {
        DispatchQueue.updateUI {
            if let view = viewController.view {
                
                let oldHud = view.viewWithTag(UIView.hudTag) as? MBProgressHUD
                oldHud?.hide(animated: false)
                
                let hud = MBProgressHUD.showAdded(to: view, animated: true)
                hud.mode = .text
                hud.tag = UIView.hudTag
                
                hud.label.numberOfLines = 0
                
                switch style {
                case .error:
                    hud.label.text = "❌ " + message
                case .success:
                    hud.label.text = "✅ " + message
                case .info:
                    hud.label.text = message
                }
                
                hud.contentColor = UIColor.white
                hud.bezelView.color = UIColor.black.withAlphaComponent(0.9)
                                
                hud.hide(animated: true, afterDelay: 2)
            }
        }
    }
    
}
