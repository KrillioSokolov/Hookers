//
//  LightThemeDesignStyleGuide.swift
//  Hookers
//
//  Created by Hookers on 4/25/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation
import UIKit

@objc
final public class LightThemeDesignStyleGuide: NSObject, DesignStyleGuide { }

// MARK: - FontStyleGuide

extension LightThemeDesignStyleGuide {
    
    public func lightFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
    }
    
    public func regularFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
    }
    
    public func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
        // medium -> semibold
        // in protocol dynamic components used name medium but for realisation used semibold
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
    }
    
    public func boldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
    }
    
    func semiboldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
    }
    
}

// MARK: - ColorStyleGuide

extension LightThemeDesignStyleGuide {
    
    public var CTAButtonTitleColor: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    public var normalCTAButtonBackgroundImage: UIImage? {
        return UIImage(color: primaryColor)
    }
    
    public var disabledCTAButtonBackgroundImage: UIImage? {
        return UIImage(color: secondaryTextColor)
    }
    
    public var normalDeleteCTAButtonBackgroundImage: UIImage? {
        return UIImage(color: errorColor)
    }
    
    public var alternativeCTAButtonBackgroundImage: UIImage? {
        return UIImage(color: primaryColor)
    }
    
    public var primaryColor: UIColor {
        return UIColor(r: 113, g: 176, b: 62)
    }
    
    public var primaryDarkColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: UIColor.black.withAlphaComponent(0.2), aboveBackgroundColor: primaryColor)
    }
    
    public var primaryLightColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: UIColor.white.withAlphaComponent(0.2), aboveBackgroundColor: primaryColor)
    }
    
    public var patternColor: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }

    public var secondaryColor: UIColor {
        return UIColor(r: 97, g: 177, b: 231)
    }
    
    public var secondaryDarkColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: UIColor.black.withAlphaComponent(0.2), aboveBackgroundColor: secondaryColor)
    }
    
    public var secondaryLightColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: UIColor.white.withAlphaComponent(0.2), aboveBackgroundColor: secondaryColor)
    }
    
    public var accentColor: UIColor {
        return UIColor(r: 108, g: 111, b: 122)
    }
    
    public var accent2Color: UIColor {
        return UIColor(r: 153, g: 88, b: 180)
    }
    
    public var dividerColor: UIColor {
        return UIColor(r: 217, g: 217, b: 217)
    }
    
    public var badgeColor: UIColor {
        return UIColor(r: 255, g: 91, b: 92)
    }
    
    public var errorColor: UIColor {
        return UIColor(r: 255, g: 91, b: 92)
    }
    
    public var warningColor: UIColor {
        return UIColor(r: 255, g: 136, b: 0)
    }
    
    public var lightWarningColor: UIColor {
        return UIColor(r: 255, g: 244, b: 229)
    }
    
    public var successColor: UIColor {
        return UIColor(r: 113, g: 176, b: 62)
    }
    
    public var backgroundScreenColor: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    public var backgroundCardColor: UIColor {
        return UIColor(r: 247, g: 247, b: 247)
    }
    
    public var cardColor: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    public var primaryTextColor: UIColor {
        return UIColor(r: 33, g: 33, b: 33)
    }
    
    public var secondaryTextColor: UIColor {
        return UIColor(r: 153, g: 153, b: 153)
    }
    
    public var accentTextColor: UIColor {
        return UIColor(r: 0, g: 122, b: 255)
    }
    
    public var accentDarkTextColor: UIColor {
        return UIColor.blue
    }
    
    public var focusTextColor: UIColor {
        return UIColor(r: 33, g: 33, b: 33)
    }
    
    public var hintTextColor: UIColor {
        return UIColor(r: 208, g: 208, b: 208)
    }
    
    public var disabledTextColor: UIColor {
        return UIColor(r: 225, g: 225, b: 225)
    }
    
    public var labelTextColor: UIColor {
        return UIColor(r: 153, g: 153, b: 153)
    }
    
    public var shadowColor: UIColor {
        return UIColor(r: 0, g: 0, b: 0, alpha: 0.1).solidRGBAboveWhiteColor
    }
    
    public var bubbleColor: UIColor {
        return UIColor(r: 240, g: 240, b: 240)
    }
    
}

extension LightThemeDesignStyleGuide: AdditionalColorStyleGuide {
    
    var senderTextColor: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
}

extension LightThemeDesignStyleGuide: StatusBarStyleGuide {
    
    var statusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

extension LightThemeDesignStyleGuide: KeyboardAppearanceStyleGuide {
    
    var keyboardAppearance: UIKeyboardAppearance {
        return .default
    }
    
}
