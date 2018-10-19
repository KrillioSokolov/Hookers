//
//  DesignStyleGuide.swift
//  Hookers
//
//  Created by Hookers on 4/25/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol DesignStyleGuide: ExternalStyleguide, AdditionalColorStyleGuide, AdditionalFontStyleGuide, StatusBarStyleGuide, KeyboardAppearanceStyleGuide { }

// RS: TODO: move methods of this protocol to common FontStyleGuide
@objc
protocol AdditionalFontStyleGuide {
    
    func semiboldFont(ofSize fontSize: CGFloat) -> UIFont
    
}

// RS: TODO: move methods of this protocol to common ColorStyleGuide
@objc
protocol AdditionalColorStyleGuide {
    
    var senderTextColor: UIColor { get }
    
}

@objc
protocol StatusBarStyleGuide {
    
    var statusBarStyle: UIStatusBarStyle { get }
    
}

@objc
protocol KeyboardAppearanceStyleGuide {
    
    var keyboardAppearance: UIKeyboardAppearance { get }
    
}

