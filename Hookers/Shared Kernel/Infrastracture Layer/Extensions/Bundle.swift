//
//  Bundle.swift
//  Hookers
//
//  Created by Sokolov Kirill on 6/4/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import Foundation

extension Bundle {
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    var bundleShortVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
}
