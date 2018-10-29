//
//  ApplicationSpinner.swift
//  Hookers
//
//  Created by Sokolov Kirill on 5/26/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import MBProgressHUD

//ML: TODO: refactor spinners and huds later

final class ApplicationSpinner: Spinner {
    
    func show(on view: UIView, text: String?, animated: Bool, blockUI: Bool) {
        let oldHud = view.viewWithTag(UIView.hudTag) as? MBProgressHUD
        if let oldHud = oldHud {
            if oldHud.mode == .indeterminate && oldHud.label.text == text && oldHud.detailsLabel.text == nil {
                return
            } else {
                oldHud.hide(animated: false)
            }
        }
        
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        
        hud.contentColor = UIColor.white
        hud.bezelView.color = UIColor.white.withAlphaComponent(0.1)
        hud.mode = .indeterminate
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.detailsLabel.text = nil
        hud.tag = UIView.hudTag
    }
    
    func hide(from view: UIView, animated: Bool) {
        MBProgressHUD.hide(for: view, animated: animated)
    }
    
}
