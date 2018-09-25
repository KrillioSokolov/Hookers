//
//  WeakContainer.swift
//  ClearMVC
//
//  Created by Sokolov Kirill on 5/5/18.
//  Copyright © 2018 Privat24. All rights reserved.
//

import Foundation

final class WeakContainer<T: AnyObject> {
    
    weak private(set) var value: T?
    
    init(value: T) {
        self.value = value
    }

}

extension Array where Element == WeakContainer<AnyObject> {
    
    mutating func appendWeakValue(_ value: AnyObject) {
        append(WeakContainer(value: value))
    }
    
    mutating func removeWeakValue(_ value: AnyObject) {
        let index = self.index { (element) -> Bool in
            if let value1 = element.value {
                return value1 === value
            }
            
            return false
        }
        
        if let index = index {
            remove(at: index)
        }
    }
    
    var allValues: [AnyObject] {
        return self.compactMap { $0.value }
    }
    
    mutating func compact() {
        self = self.filter { $0.value != nil }
    }
    
}
