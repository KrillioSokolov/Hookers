//
//  Collection.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/27/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import Foundation

extension Collection {
    
    func dictionary<K, V>(transform:(_ element: Iterator.Element) -> [K: V]) -> [K: V] {
        var dictionary = [K: V]()
        self.forEach { element in
            for (key, value) in transform(element) {
                dictionary[key] = value
            }
        }
        
        return dictionary
    }
    
}
