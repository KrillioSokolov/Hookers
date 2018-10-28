//
//  DataStateLocking.swift
//  ClearMVC
//
//  Created by Maxim Letushov on 4/30/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

public protocol DataStateLocking {
    
    func protectDataState(inCriticalSection criticalSection: () -> Void)
    
}

public final class DataStateRecurciveLock: DataStateLocking {
    
    private var recurciveLock: NSRecursiveLock = NSRecursiveLock()
    
    public func protectDataState(inCriticalSection criticalSection: () -> Void) {
        recurciveLock.lock()
        criticalSection()
        recurciveLock.unlock()
    }
    
    public init() {}
    
}

public final class DataStateNoEffectLock: DataStateLocking {
    
    public func protectDataState(inCriticalSection criticalSection: () -> Void) {
        criticalSection()
    }
    
    public init() {}
    
}
