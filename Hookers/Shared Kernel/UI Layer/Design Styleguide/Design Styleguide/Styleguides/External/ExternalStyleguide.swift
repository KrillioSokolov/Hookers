//
//  ExternalStyleguide.swift
//  Hookers
//
//  Created by Kirill Sokolov on 08.02.2018.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation
import UIKit

@objc
public protocol ColorStyleGuide: class {
    
    var primaryColor: UIColor { get }
    var primaryDarkColor: UIColor { get }
    var primaryLightColor: UIColor { get }
    var patternColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var secondaryDarkColor: UIColor { get }
    var secondaryLightColor: UIColor { get }
    var accentColor: UIColor { get }
    var accent2Color: UIColor { get }
    var dividerColor: UIColor { get }
    var badgeColor: UIColor { get }
    var errorColor: UIColor { get }
    var warningColor: UIColor { get }
    var lightWarningColor: UIColor { get }
    var successColor: UIColor { get }
    var backgroundScreenColor: UIColor { get }
    var backgroundCardColor: UIColor { get }
    var cardColor: UIColor { get }
    var primaryTextColor: UIColor { get }
    var secondaryTextColor: UIColor { get }
    var accentTextColor: UIColor { get }
    var accentDarkTextColor: UIColor { get }
    var focusTextColor: UIColor { get }
    var hintTextColor: UIColor { get }
    var disabledTextColor: UIColor { get }
    var labelTextColor: UIColor { get }
    var shadowColor: UIColor { get }
    var bubbleColor: UIColor { get }
    
    var CTAButtonTitleColor: UIColor { get }
    var normalCTAButtonBackgroundImage: UIImage? { get }
    var disabledCTAButtonBackgroundImage: UIImage? { get }
    var normalDeleteCTAButtonBackgroundImage: UIImage? { get }
    var alternativeCTAButtonBackgroundImage: UIImage? { get }
    
}

@objc
public protocol FontStyleGuide: class {
    
    func lightFont(ofSize fontSize: CGFloat) -> UIFont
    func regularFont(ofSize fontSize: CGFloat) -> UIFont
    func mediumFont(ofSize fontSize: CGFloat) -> UIFont
    func boldFont(ofSize fontSize: CGFloat) -> UIFont
    
}

@objc
public protocol ExternalStyleguide: ColorStyleGuide, FontStyleGuide {}
