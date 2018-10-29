//
//  UIViewController.swift
//  Hookers
//
//  Created by Kirill Sokolov on 05.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var isModal: Bool {
        return presentingViewController != nil ||
            navigationController?.presentingViewController?.presentedViewController === navigationController ||
            tabBarController?.presentingViewController is UITabBarController
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController: SpinnerPresenting {
    
    func showSpinner(message: String? = nil, animated: Bool = true, blockUI: Bool = true) {
        ApplicationSpinner().show(on: view, text: message, animated: animated, blockUI: blockUI)
    }
    
    func hideSpinner(animated: Bool = true) {
        ApplicationSpinner().hide(from: view, animated: animated)
    }
    
}
