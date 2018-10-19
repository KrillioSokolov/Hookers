//
//  Dispatcher.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/7/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

typealias DispatchToken = String

protocol Dispatcher {
    
    func dispatch<T: Event>(type: T.Type, result: Result<T.Payload>)
    
    @discardableResult
    func register<T: Event>(type: T.Type, handler: @escaping (Result<T.Payload>, DispatchToken) -> ()) -> DispatchToken
    
    func unregister(dispatchToken: DispatchToken)
    
    func waitFor<T: Event>(dispatchTokens: [DispatchToken], type: T.Type, result: Result<T.Payload>)
    
}

final class DefaultDispatcher: Dispatcher {
    
    enum Status {
        case waiting
        case pending
        case handled
    }
    
    private var callbacks: [DispatchToken: AnyObject] = [:]
    
    init() {}
    
    deinit {
        callbacks.removeAll()
    }
    
    func dispatch<T: Event>(type: T.Type, result: Result<T.Payload>) {
        objc_sync_enter(self)
        
        startDispatching(type: type)
        for dispatchToken in callbacks.keys {
            invokeCallback(dispatchToken: dispatchToken, type: type, result: result)
        }
        
        objc_sync_exit(self)
    }
    
    @discardableResult
    func register<T>(type: T.Type, handler: @escaping (Result<T.Payload>, DispatchToken) -> ()) -> DispatchToken where T: Event {
        let nextDispatchToken = NSUUID().uuidString
        callbacks[nextDispatchToken] = DispatchCallback<T>(type: type, handler: handler)
        return nextDispatchToken
    }
    
    func unregister(dispatchToken: DispatchToken) {
        callbacks.removeValue(forKey: dispatchToken)
    }
    
    func waitFor<T: Event>(dispatchTokens: [DispatchToken], type: T.Type, result: Result<T.Payload>) {
        for dispatchToken in dispatchTokens {
            guard let callback = callbacks[dispatchToken] as? DispatchCallback<T> else { continue }
            switch callback.status {
            case .handled:
                continue
            case .pending:
                // Circular dependency detected while
                continue
            default:
                invokeCallback(dispatchToken: dispatchToken, type: type, result: result)
            }
        }
    }
    
    private func startDispatching<T: Event>(type: T.Type) {
        for (dispatchToken, _) in callbacks {
            guard let callback = callbacks[dispatchToken] as? DispatchCallback<T> else { continue }
            callback.status = .waiting
        }
    }
    
    private func invokeCallback<T: Event>(dispatchToken: DispatchToken, type: T.Type, result: Result<T.Payload>) {
        guard let callback = callbacks[dispatchToken] as? DispatchCallback<T> else { return }
        guard callback.status == .waiting else { return }
        
        callback.status = .pending
        callback.handler(result, dispatchToken)
        callback.status = .handled
    }
    
}

private class DispatchCallback<T: Event> {
    
    let type: T.Type
    let handler: (Result<T.Payload>, DispatchToken) -> ()
    var status = DefaultDispatcher.Status.waiting
    
    init(type: T.Type, handler: @escaping (Result<T.Payload>, DispatchToken) -> ()) {
        self.type = type
        self.handler = handler
    }
    
}
