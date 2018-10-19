//
//  TabBarEmbedCoordinable.swift
//  Hookers
//
//  Created by Hookers on 5/29/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

struct TabBarItemInfo {
    
    let title: String?
    let icon: UIImage?
    let highlightedIcon: UIImage?
    let accessibilityLabel: String? 
    let accessibilityHint: String?
    let accessibilityValue: String?
    let accessibilityId: String?
    
    init(title: String?, icon: UIImage?, highlightedIcon: UIImage?, accessibilityLabel: String? = nil, accessibilityHint: String? = nil, accessibilityValue: String? = nil,  accessibilityId: String? = nil) {
        
        self.title = title
        self.icon = icon
        self.highlightedIcon = highlightedIcon
        self.accessibilityLabel = accessibilityLabel 
        self.accessibilityHint = accessibilityHint
        self.accessibilityValue = accessibilityValue
        self.accessibilityId = accessibilityId
    }
}

class TabBarEmbedCoordinator: Coordinator {
    
    private var tabItemInfo: TabBarItemInfo!
    
    init(context: CoordinatingContext, tabItemInfo: TabBarItemInfo) {
        self.tabItemInfo = tabItemInfo
        
        super.init(context: context)
    }
    
    func tabItem() -> UITabBarItem {
        let item = UITabBarItem(
            title: tabItemInfo.title,
            image: tabItemInfo.icon,
            selectedImage: tabItemInfo.highlightedIcon)
       
        return item
    }
    
}
