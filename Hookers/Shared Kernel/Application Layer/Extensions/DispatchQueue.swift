//
//  DispatchQueue.swift
//  Hookers
//
//  Created by Sokolov Kirill on 6/8/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    class func updateUI(_ work: @escaping () -> Void) {
        if Thread.current.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: {
                work()
            })
        }
    }
    
    class func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
}
