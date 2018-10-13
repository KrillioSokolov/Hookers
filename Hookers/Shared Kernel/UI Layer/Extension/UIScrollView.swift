//
//  UIScrollView.swift
//  Hookers
//
//  Created by Sokolov Kirill on 2/5/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToBottomIfNeeded(withIndentation indent: CGFloat = 0.0, animated: Bool = false) {
        guard bounds.size.height - contentInset.bottom - indent < contentSize.height else { return }
        
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom - indent)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    var scrolledToTop: Bool {
        let topEdge = 0 - contentInset.top
        return contentOffset.y <= topEdge
    }
    
    var scrolledToBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return contentOffset.y >= bottomEdge
    }
    
    func isExpectedScrollToTop(with targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Bool {
        let topEdge = 0 - contentInset.top
        
        return targetContentOffset.pointee.y <= topEdge
    }
    
    func isExpectedScrollToBottom(with targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return targetContentOffset.pointee.y >= bottomEdge
    }

    
}
