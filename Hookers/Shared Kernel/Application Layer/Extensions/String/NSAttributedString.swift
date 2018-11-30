//
//  NSM.swift
//  Hookers
//
//  Created by Stas Chelak on 11/27/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    static func make(from stringList: [String], font: UIFont, bullet: String = "•", indentation: CGFloat = 5, lineSpacing: CGFloat = 0, paragraphSpacing: CGFloat = 5, textColor: UIColor = .white) -> NSAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.tabStops = [ NSTextTab(textAlignment: .left, location: indentation, options: [:]) ]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        
        for string in stringList {
            let formattedString = bullet + "\t" + string + "\n"
            
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes( [NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(attributes, range: NSMakeRange(0, attributedString.length))
            bulletList.append(attributedString)
        }
        
        return bulletList
    }

    
}
