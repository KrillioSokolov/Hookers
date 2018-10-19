//
//  Array.swift
//  Hookers
//
//  Created by Kirill Sokolov on 15.12.2018.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    var uniqueItems: Array {
        return reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
    }

}

extension Array where Element: Equatable {
    
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) {
                return false
            }
        }
        
        return true
    }
    
}

