//
//  SpinnerPressenting.swift
//  Hookers
//
//  Created by Kirill Sokolov on 29.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

protocol SpinnerPresenting {
    
    func showSpinner(message: String?, animated: Bool, blockUI: Bool)
    func hideSpinner(animated: Bool)
    
}
