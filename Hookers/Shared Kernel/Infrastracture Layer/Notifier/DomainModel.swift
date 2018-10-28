//
//  DomainModel.swift
//  ClearMVC
//
//  Created by Maxim Letushov on 4/25/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

//------------------------------------------------------------------------------

public protocol DataStateChange {}                //just a marker protocol

public protocol DataStateListening: class {
    
    func domainModel(_ model: DomainModel, didChangeDataStateOf change: DataStateChange)
    
}

public extension DataStateListening {
    
    func domainModel(_ model: DomainModel, didChangeDataStateOf change: DataStateChange) {}
    
}

public protocol DataStateSubscribing {
    
    func addDataStateListener(_ listener: DataStateListening)
    func removeDataStateListener(_ listener: DataStateListening)
    
}

//------------------------------------------------------------------------------

public protocol ModelActivity {}                     //just a marker protocol

public protocol DomainError: Error { }

public enum ActivityStage {
    
    case willStart
    case didFinish(error: DomainError?)
    
}

public protocol ActivityListening: class {
    
    func domainModel(_ model: DomainModel, performsActivity activity: ModelActivity, atStage stage: ActivityStage)
    
}

public extension ActivityListening {
    
    func domainModel(_ model: DomainModel, performsActivity activity: ModelActivity, atStage stage: ActivityStage) {}
    
}

public protocol ActivitySubscribing {
    
    func addActivityListener(_ listener: ActivityListening)
    func removeActivityListener(_ listener: ActivityListening)
    
}

//------------------------------------------------------------------------------

public protocol DataStateAccess {
    
    func readDataState(work: (_ model: DomainModel) -> Void)
    
}

public protocol ModelInput: DataStateSubscribing, ActivitySubscribing, DataStateAccess {}
public protocol ModelOutput: DataStateListening, ActivityListening {}

//------------------------------------------------------------------------------

open class DomainModel {
    
    fileprivate var dataStateListeners = [WeakContainer<AnyObject>]()
    fileprivate var activityListeners = [WeakContainer<AnyObject>]()
    
    public let taskDispatcher: Dispatching
    fileprivate let dataStateLock: DataStateLocking
    
    public init(taskDispatcher: Executor = Executor(executorType: .concurrent, dispatchType: .async),
                dataStateLock: DataStateLocking = DataStateRecurciveLock()) {
        self.taskDispatcher = taskDispatcher
        self.dataStateLock = dataStateLock
    }
    
}

extension DomainModel: DataStateSubscribing, ActivitySubscribing {
    
    public func addDataStateListener(_ listener: DataStateListening) {
        dataStateLock.protectDataState {
            dataStateListeners.appendWeakValue(listener)
        }
    }
    
    public func removeDataStateListener(_ listener: DataStateListening) {
        dataStateLock.protectDataState {
            dataStateListeners.removeWeakValue(listener)
        }
    }
    
    public func addActivityListener(_ listener: ActivityListening) {
        dataStateLock.protectDataState {
            activityListeners.appendWeakValue(listener)
        }
    }
    
    public func removeActivityListener(_ listener: ActivityListening) {
        dataStateLock.protectDataState {
            activityListeners.removeWeakValue(listener)
        }
    }
    
}

//------------------------------------------------------------------------------

extension DomainModel: DataStateAccess {
    
    public func readDataState(work: (_ model: DomainModel) -> Void) {
        dataStateLock.protectDataState {
            work(self)
        }
    }
    
}

extension DomainModel {
    
    fileprivate func notifyListeners(activity: ModelActivity, passesStage stage: ActivityStage) {
        dataStateLock.protectDataState {
            let listeners = self.activityListeners.allValues as! [ActivityListening]
            listeners.forEach { (listener) in
                listener.domainModel(self, performsActivity: activity, atStage: stage)
            }
        }
    }
    
    fileprivate func notifyListeners(dataStateChangeOf change: DataStateChange) {
        dataStateLock.protectDataState {
            let listeners = self.dataStateListeners.allValues as! [DataStateListening]
            listeners.forEach { (listener) in
                listener.domainModel(self, didChangeDataStateOf: change)
            }
        }
    }
    
}

extension DomainModel {
    
    public func perform(activity: ModelActivity, work: (@escaping (DomainError?) -> Void) -> Void ) {
        notifyListeners(activity: activity, passesStage: .willStart)
        
        work { error in
            self.notifyListeners(activity: activity, passesStage: .didFinish(error: error))
        }
    }
    
    public func changeDataStateOf(_ change: DataStateChange, work: () -> Void) {
        dataStateLock.protectDataState {
            work()
            self.notifyListeners(dataStateChangeOf: change)
        }
    }
    
    public func changeDataState(work: () -> Void) {
        dataStateLock.protectDataState(inCriticalSection: work)
    }
    
}

//------------------------------------------------------------------------------------
