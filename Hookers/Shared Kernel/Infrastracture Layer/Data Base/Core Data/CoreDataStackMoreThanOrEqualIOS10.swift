//
//  CoreDataStackMoreThanOrEqualIOS10.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStackMoreThanOrEqualIOS10 {
    
    private var modelName: String
    private var storeDirectory: URL
    
    // For excluding merge conflicts we use OperationQueue as described here https://stackoverflow.com/a/42745378
    private lazy var persistentContainerQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        return queue
    }()
        
    @available(iOS 10.0, *)
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: self.modelName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: mom)
        
        let description = NSPersistentStoreDescription(url: self.storeDirectory)
        container.persistentStoreDescriptions = [description]
        
        // RS: loadPersistentStores completion handler is called sync
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    init(forModel modelName: String, storeDirectory: URL) {
        self.modelName = modelName
        self.storeDirectory = storeDirectory
    }
        
    func save(useBackgroundContext context: NSManagedObjectContext) -> Error? {
        do {
            try context.save()
            return nil
        } catch let error {
            return error
        }
    }
    
}

extension CoreDataStackMoreThanOrEqualIOS10: CoreDataOperation {
    
    func asyncCreateOrUpdate(withTask task: @escaping (NSManagedObjectContext) -> (), completion: @escaping (Error?) -> ()) {
        if #available(iOS 10.0, *) {
            persistentContainerQueue.addOperation {
                let backgroundContext = self.persistentContainer.newBackgroundContext()
                
                backgroundContext.performAndWait {
                    task(backgroundContext)
                    let error = self.save(useBackgroundContext: backgroundContext)
                    completion(error)
                }
            }
        }
    }
    
    func asyncRead(withTask task: @escaping (NSManagedObjectContext) ->()) {
        if #available(iOS 10.0, *) {
            persistentContainer.performBackgroundTask({ context in
                task(context)
            })
        }
    }
    
    func read(withTask task: @escaping (NSManagedObjectContext) -> ([NSManagedObject]?, Error?)) -> ([NSManagedObject]?, Error?) {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            
            return task(context)
        }
        
        let error = NSError(domain: "CoreDataStackMoreThanOrEqualIOS10ErrorDomain", code: 1,
                            userInfo: [NSLocalizedDescriptionKey:
                                "Can't get background managed object context."])
        return (nil, error)
    }
    
    func asyncDelete(withTask task: @escaping (NSManagedObjectContext) ->(), completion: @escaping (Error?) -> ()) {
        if #available(iOS 10.0, *) {
            persistentContainer.performBackgroundTask { privateManagedObjectContext in
                do {
                    task(privateManagedObjectContext)
                    
                    try privateManagedObjectContext.save()
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            }
        }
    }
    
    func delete(withTask task: @escaping (NSManagedObjectContext) ->()) -> Error? {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            do {
                task(context)
                
                try context.save()
                return nil
            } catch let error {
                return error
            }
        }
        
        let error = NSError(domain: "CoreDataStackMoreThanOrEqualIOS10ErrorDomain", code: 1,
                            userInfo: [NSLocalizedDescriptionKey:
                                "Can't get background managed object context."])
        
        return error
    }
    
    func count(withTask task: @escaping (NSManagedObjectContext) -> (Int?, Error?)) -> (Int?, Error?) {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            
            return task(context)
        }
        
        let error = NSError(domain: "CoreDataStackMoreThanOrEqualIOS10ErrorDomain", code: 1,
                            userInfo: [NSLocalizedDescriptionKey:
                                "Can't get background managed object context."])
        
        return (nil, error)
    }
    
    func dropDataBaseIfExists() -> Error? {
        if #available(iOS 10.0, *) {
            for store in persistentContainer.persistentStoreCoordinator.persistentStores {
                guard let storeURL = store.url else { continue }
                
                do {
                    try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: store.options)
                    
                    return nil
                } catch let error {
                    return error
                }
            }
        } else {
            let error = NSError(domain: "CoreDataStackMoreThanOrEqualIOS10ErrorDomain", code: 1,
                                userInfo: [NSLocalizedDescriptionKey:
                                    "Can't get persistentStoreCoordinator."])
            
            return error
        }

        return nil
    }
    
}
