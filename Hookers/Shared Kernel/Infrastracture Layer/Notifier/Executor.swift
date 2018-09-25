//
//  Executor.swift
//  ClearMVC
//
//  Created by Sokolov Kirill on 4/28/18.
//  Copyright © 2018 Privat24. All rights reserved.
//

import Foundation

public protocol Dispatching {
    
    func dispatch(_ work: @escaping () -> Void)
    
}

public enum ExecutorType {
    
    case serial, concurrent
    
}

public enum DispatchType {
    
    case sync, async
    
}

public final class Executor: Dispatching {
    
    let executorType: ExecutorType
    let dispatchType: DispatchType
    
    private let queue: DispatchQueue
    
    public init(executorType: ExecutorType, dispatchType: DispatchType) {
        self.executorType = executorType
        self.dispatchType = dispatchType
        
        let label = "\(String(describing: type(of: self)))_\(String(describing: executorType))_\(UUID().uuidString)"
        
        switch executorType {
        case .serial:
            queue = DispatchQueue(label: label)
        case .concurrent:
            queue = DispatchQueue(label: label, attributes: [.concurrent])
        }
    }
    
    public func dispatch(_ work: @escaping () -> Void) {
        
        switch dispatchType {
        case .sync:
            queue.sync(execute: work)
        case .async:
            queue.async(execute: work)
        }
        
    }
    
}
