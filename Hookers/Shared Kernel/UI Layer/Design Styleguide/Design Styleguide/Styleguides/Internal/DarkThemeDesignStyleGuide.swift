//
//  DarkThemeDesignStyleGuide.swift
//  Hookers
//
//  Created by Hookers on 4/25/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation
import UIKit

@objc
final public class DarkThemeDesignStyleGuide: NSObject, DesignStyleGuide { }

// MARK: - FontStyleGuide

extension DarkThemeDesignStyleGuide {
    
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

    public func semiboldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
    }
    
}

// MARK: - ColorStyleGuide

extension DarkThemeDesignStyleGuide {
    
    public var CTAButtonTitleColor: UIColor {
        //ML: TODO: check this color for Dark Theme
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
        return UIColor(r: 99, g: 11, b: 175)
    }
    
    public var primaryDarkColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: UIColor.black.withAlphaComponent(0.2), aboveBackgroundColor: primaryColor)
    }
    
    public var primaryLightColor: UIColor {
        return UIColor.solidRGB(fromRGBAColor: UIColor.white.withAlphaComponent(0.2), aboveBackgroundColor: primaryColor)
    }
    
    public var patternColor: UIColor {
        return UIColor(r: 64, g: 64, b: 64)
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
        return UIColor(r: 80, g: 80, b: 80)
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
        return UIColor(r: 110, g: 79, b: 33)
    }
    
    public var successColor: UIColor {
        return UIColor(r: 113, g: 176, b: 62)
    }
    
    public var backgroundScreenColor: UIColor {
        return UIColor(r: 34, g: 38, b: 44)
    }
    
    public var backgroundCardColor: UIColor {
        return UIColor(r: 17, g: 17, b: 17)
    }
    
    public var cardColor: UIColor {
        return UIColor(r: 50, g: 50, b: 50)
    }
    
    public var primaryTextColor: UIColor {
        return UIColor(r: 240, g: 240, b: 240)
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
        return UIColor(r: 204, g: 204, b: 204)
    }
    
    public var hintTextColor: UIColor {
        return UIColor(r: 102, g: 102, b: 102)
    }
    
    public var disabledTextColor: UIColor {
        return UIColor(r: 64, g: 64, b: 64)
    }
    
    public var labelTextColor: UIColor {
        return UIColor(r: 153, g: 153, b: 153)
    }
    
    public var shadowColor: UIColor {
        return UIColor(r: 0, g: 0, b: 0, alpha: 0.2).solidRGBAboveWhiteColor
    }
    
    public var bubbleColor: UIColor {
        return .black//UIColor.white.withAlphaComponent(0.1)
    }
    
}

extension DarkThemeDesignStyleGuide: AdditionalColorStyleGuide {
    
    var senderTextColor: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
}

extension DarkThemeDesignStyleGuide: StatusBarStyleGuide {
    
    var statusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension DarkThemeDesignStyleGuide: KeyboardAppearanceStyleGuide {
    
    var keyboardAppearance: UIKeyboardAppearance {
        return .dark
    }
    
}
