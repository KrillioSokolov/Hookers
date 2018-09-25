//
//  CoreDataDBService.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataDBService {
    
    private var modelName: String
    private var storeDirectory: URL
    
    private lazy var coreDataOpearation: CoreDataOperation = {
        if #available(iOS 10.0, *) {
            return CoreDataStackMoreThanOrEqualIOS10(forModel: self.modelName, storeDirectory: self.storeDirectory)
        } else {
            return CoreDataStackLessThanIOS10(forModel: self.modelName, storeDirectory: self.storeDirectory)
        }
    }()
    
    init(forModel modelName: String, storeDirectory: URL) {
        self.modelName = modelName
        self.storeDirectory = storeDirectory
    }
    
    // MARK: - Private methods
    
    fileprivate func fetchRequest(for entity: CoreDataModelConvertible.Type) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: entity.entityName)
    }
    
}

// MARK: - Private methods

extension CoreDataDBService {
    
    fileprivate func asyncCreateOrUpdate<T: Stored>(objects: [T], completion: DBOperationCompletion?) {
        
        let task: (NSManagedObjectContext) -> () = { context in
            for object in objects {
                if let coreDataConvertibleObject = object as? CoreDataModelConvertible {
                    var managedObject: NSManagedObject
                    let type = Swift.type(of: coreDataConvertibleObject)
                    if let existingManagedObject = self.findManagedObject(context, type: type, primaryValue: object.valueOfPrimaryKey!.description) {
                        managedObject = existingManagedObject
                    } else {
                        managedObject = NSEntityDescription.insertNewObject(forEntityName: type.entityName, into: context)
                    }
                    coreDataConvertibleObject.mapToNSManagedObject(withManagedObject: managedObject, context: context)
                }
            }
        }
        
        coreDataOpearation.asyncCreateOrUpdate(withTask: task) { error in
            let dbOperationResult = DBOperationResult(objects: objects, error: error)
            
            completion?(dbOperationResult)
        }
    }
    
    fileprivate func asyncRead<T>(coreDataModelType: CoreDataModelConvertible.Type, request: FetchRequest<T>, completion: DBOperationCompletion?) {
        
        let task: (NSManagedObjectContext) -> () = { backgroundContext in
            let fetchRequest = self.fetchRequest(for: coreDataModelType)
            
            fetchRequest.predicate = request.predicate
            fetchRequest.sortDescriptors = [request.sortDescriptor].compactMap { $0 }
            fetchRequest.fetchLimit = request.fetchLimit
            fetchRequest.fetchOffset = request.fetchOffset
            
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { asynchronousFetchResult in
                
                guard let result = asynchronousFetchResult.finalResult as? [NSManagedObject] else { return }
                
                let objects = result.compactMap { coreDataModelType.mapToStored(fromManagedObject: $0) as? T }
                let dbOperationResult = DBOperationResult(objects: objects, error: nil)
                
                completion?(dbOperationResult)
            }
            
            do {
                try backgroundContext.execute(asynchronousFetchRequest)
            } catch let error {
                
                let dbOperationResult = DBOperationResult(objects: nil, error: error)
                                
                completion?(dbOperationResult)
            }
        }
        
        coreDataOpearation.asyncRead(withTask: task)
    }
    
    fileprivate func read<T>(coreDataModelType: CoreDataModelConvertible.Type, request: FetchRequest<T>) -> DBOperationResult {
        
        let task: ((NSManagedObjectContext) -> ([NSManagedObject]?, Error?)) = { context in
            let fetchRequest = self.fetchRequest(for: coreDataModelType)
            
            fetchRequest.predicate = request.predicate
            fetchRequest.sortDescriptors = [request.sortDescriptor].compactMap { $0 }
            fetchRequest.fetchLimit = request.fetchLimit
            fetchRequest.fetchOffset = request.fetchOffset
            
            do {
                let result = try context.fetch(fetchRequest) as? [NSManagedObject]
                return (result, nil)
            } catch let error {
                return (nil, error)
            }
        }
        
        let result = coreDataOpearation.read(withTask: task)
        if let managedObjects = result.0 {
            let objects = managedObjects.compactMap { coreDataModelType.mapToStored(fromManagedObject: $0) as? T }
            return DBOperationResult(objects: objects, error: nil)
        } else {
            return DBOperationResult(objects: nil, error: result.1)
        }
        
    }
    
    fileprivate func deleteObjects<T: Stored>(objects: [T]) -> DBOperationResult {
        let task: ((NSManagedObjectContext) -> ()) = { context in
            for object in objects {
                if let coreDataConvertibleObject = object as? CoreDataModelConvertible {
                    let type = Swift.type(of: coreDataConvertibleObject)
                    if let manageObject = self.findManagedObject(context, type: type, primaryValue: String(describing: object.valueOfPrimaryKey!)) {
                        context.delete(manageObject)
                    }
                }
            }
        }
        
        if let error = coreDataOpearation.delete(withTask: task) {
            return (nil, error)
        } else {
            return (objects, nil)
        }
    }
    
    func count<T>(coreDataModelType: CoreDataModelConvertible.Type, request: FetchRequest<T>) -> (Int?, Error?) {
        let task: ((NSManagedObjectContext) -> (Int?, Error?)) = { context in
            let fetchRequest = self.fetchRequest(for: coreDataModelType)
            
            fetchRequest.predicate = request.predicate
            fetchRequest.sortDescriptors = [request.sortDescriptor].compactMap { $0 }
            fetchRequest.fetchLimit = request.fetchLimit
            fetchRequest.fetchOffset = request.fetchOffset
            
            do {
                let count = try context.count(for: fetchRequest)
                return (count, nil)
            } catch let error {
                return (nil, error)
            }
        }
        
        let result = coreDataOpearation.count(withTask: task)
        
        return (result.0, result.1)
    }
    
    fileprivate func asyncDeleteObjects<T: Stored>(objects: [T], completion: DBOperationCompletion?) {
        
        let task: ((NSManagedObjectContext) -> ()) = { context in
            for object in objects {
                if let coreDataConvertibleObject = object as? CoreDataModelConvertible {
                    let type = Swift.type(of: coreDataConvertibleObject)
                    if let manageObject = self.findManagedObject(context, type: type, primaryValue: String(describing: object.valueOfPrimaryKey!)) {
                        context.delete(manageObject)
                    }
                }
            }
        }
        
        coreDataOpearation.asyncDelete(withTask: task) { error in
            let dbOperationResult = DBOperationResult(objects: objects, error: error)
            completion?(dbOperationResult)
        }
        
    }
    
    private func findManagedObject(_ context: NSManagedObjectContext, type: CoreDataModelConvertible.Type, primaryValue: String) -> NSManagedObject? {
        guard let primaryKey = type.primaryKey else {
            return nil
        }
        
        let primaryKeyPredicate = NSPredicate(format: "\(primaryKey) == %@", primaryValue)
        let fetchRequest = self.fetchRequest(for: type)
        fetchRequest.predicate = primaryKeyPredicate
        let result = try? context.fetch(fetchRequest) as! [NSManagedObject]
        
        return result?.first
    }
    
}

extension CoreDataDBService: DataBaseService {
    
    // MARK: - Sync operations
    
    func read<T>(_ request: FetchRequest<T>) -> DBOperationResult {
        guard let coreDataModelType = T.self as? CoreDataModelConvertible.Type else {
            fatalError("CoreDataDBClient can manage only types which conform to CoreDataModelConvertible")
        }
        
        return read(coreDataModelType: coreDataModelType, request: request)
    }
    
    @discardableResult
    func delete<T: Stored>(_ objects: [T]) -> DBOperationResult {
        return deleteObjects(objects: objects)
    }
    
    // MARK: - Async operations
    
    func asyncCreateOrUpdate<T: Stored>(_ objects: [T], completion: DBOperationCompletion?) {
        return asyncCreateOrUpdate(objects: objects, completion: completion)
    }
    
    func asyncRead<T>(_ request: FetchRequest<T>, completion: @escaping DBOperationCompletion) {
        guard let coreDataModelType = T.self as? CoreDataModelConvertible.Type else {
            fatalError("CoreDataDBClient can manage only types which conform to CoreDataModelConvertible")
        }

        return asyncRead(coreDataModelType: coreDataModelType, request: request, completion: completion)
    }
    
    func asyncDelete<T: Stored>(_ objects: [T], completion: DBOperationCompletion?) {
        return asyncDeleteObjects(objects: objects, completion: completion)
    }
    
    // MARK: - Drop data base
    
    func dropDataBaseIfExists() -> Error? {
        return coreDataOpearation.dropDataBaseIfExists()
    }
    
    func count<T>(type: T.Type, request: FetchRequest<T>) -> (Int?, Error?) {
        guard let coreDataModelType = T.self as? CoreDataModelConvertible.Type else {
            fatalError("CoreDataDBClient can manage only types which conform to CoreDataModelConvertible")
        }
        
        return count(coreDataModelType: coreDataModelType, request: request)
    }
    
}
