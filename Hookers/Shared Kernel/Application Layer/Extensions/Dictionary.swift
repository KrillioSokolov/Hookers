//
//  Dictionary.swift
//  Hookers
//
//  Created by Kirill Sokolov on 28.02.2018.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

extension Dictionary where Value: Any {
    
    static func +(lhs: [Key : Value], rhs: [Key : Value]) -> [Key : Value] {
        var result = lhs
        
        for (key, value) in rhs {
            result[key] = value
        }
        
        return result
    }
    
}
