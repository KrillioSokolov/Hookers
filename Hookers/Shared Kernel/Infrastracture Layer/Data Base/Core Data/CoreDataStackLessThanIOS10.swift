//
//  CoreDataStackLessThanIOS10.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStackLessThanIOS10 {
    
    private var modelName: String
    private var storeDirectory: URL
    
    fileprivate var mainManagedObjectContext: NSManagedObjectContext!
    fileprivate var childManagedObjectContext: NSManagedObjectContext!
    fileprivate var writerManagedObjectContext: NSManagedObjectContext!
    
    init(forModel modelName: String, storeDirectory: URL) {
        self.modelName = modelName
        self.storeDirectory = storeDirectory
        
        createStack()
    }
    
    private func createStack() {
        
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: self.modelName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        writerManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        writerManagedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedObjectContext.parent = writerManagedObjectContext
        
        childManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        childManagedObjectContext.parent = mainManagedObjectContext
        
        let options = [ NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        DispatchQueue.global(qos: .background).async {
            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeDirectory, options: options)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    func save(withTask task: @escaping (NSManagedObjectContext) ->(), completion: @escaping (Error?) -> ()) {
        childManagedObjectContext.perform { [weak self] in
            guard let strongSelf = self else { return }
            
            do {                
                task(strongSelf.childManagedObjectContext)
                
                try strongSelf.childManagedObjectContext.save()
                
                strongSelf.mainManagedObjectContext.perform {
                    do {
                        try strongSelf.mainManagedObjectContext.save()
                        
                        strongSelf.writerManagedObjectContext.perform {
                            do {
                                try strongSelf.writerManagedObjectContext.save()
                                completion(nil)
                            } catch let error {
                                completion(error)
                            }
                        }
                    } catch let error {
                        completion(error)
                    }
                }
            } catch let error {
                completion(error)
            }
        }
    }
    
}

extension CoreDataStackLessThanIOS10: CoreDataOperation {
        
    func asyncCreateOrUpdate(withTask task: @escaping (NSManagedObjectContext) ->(), completion: @escaping (Error?) -> ()) {
        save(withTask: task, completion: { error in
            completion(error)
        })
    }
    
    func asyncRead(withTask task: @escaping (NSManagedObjectContext) ->()) {
        if let backgroundContext = childManagedObjectContext {
            task(backgroundContext)
        }
    }
    
    func read(withTask task: @escaping ((NSManagedObjectContext) -> ([NSManagedObject]?, Error?))) -> ([NSManagedObject]?, Error?) {
        if let context = childManagedObjectContext {
            return task(context)
        }
        
        let error = NSError(domain: "CoreDataStackLessThanIOS10ErrorDomain", code: 1,
                            userInfo: [NSLocalizedDescriptionKey:
                                "Can't get child managed object context."])
        return (nil, error)
    }
    
    func asyncDelete(withTask task: @escaping (NSManagedObjectContext) ->(), completion: @escaping (Error?) -> ()) {
        save(withTask: task, completion: { error in
            completion(error)
        })
    }
    
    func delete(withTask task: @escaping (NSManagedObjectContext) ->()) -> Error? {
        
        task(mainManagedObjectContext)
        do {
            try mainManagedObjectContext.save()
            return nil
        } catch let error {
            return error
        }
    }
    
    func count(withTask task: @escaping (NSManagedObjectContext) -> (Int?, Error?)) -> (Int?, Error?) {
        if let context = mainManagedObjectContext {
            return task(context)
        }
        
        let error = NSError(domain: "CoreDataStackMoreThanOrEqualIOS10ErrorDomain", code: 1,
                            userInfo: [NSLocalizedDescriptionKey:
                                "Can't get child managed object context."])
        
        return (nil, error)
    }
    
    func dropDataBaseIfExists() -> Error? {
        let persistentStoreCoordinator = mainManagedObjectContext.parent?.persistentStoreCoordinator
        if let persistentStore = persistentStoreCoordinator?.persistentStore(for: storeDirectory) {
            try? persistentStoreCoordinator?.remove(persistentStore)
            try? FileManager.default.removeItem(at: storeDirectory)
        }
        
        return nil
    }
    
}

