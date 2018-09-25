//
//  DataBaseService.swift
//  CoreDataMultipleVersions
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

protocol Stored {
    
    // RS: Primary key for an object
    static var primaryKey: String? { get }
    
    // RS: Primary value for an instance
    var valueOfPrimaryKey: CustomStringConvertible? { get }
    
}

extension Stored {
    
    static var primaryKey: String? { return nil }
    static var valueOfPrimaryKey: CVarArg? { return nil }
    
}

typealias DBOperationResult = (objects: [Stored]?, error: Error?)
typealias DBOperationCompletion = (DBOperationResult) -> Void

protocol DataBaseService {
    
    // MARK: - Sync methods
    
    func read<T>(_ request: FetchRequest<T>) -> DBOperationResult
    
    @discardableResult
    func delete<T: Stored>(_ objects: [T]) -> DBOperationResult
    
    func count<T>(type: T.Type, request: FetchRequest<T>) -> (Int?, Error?)
    
    // MARK: - Async methods
    
    func asyncCreateOrUpdate<T: Stored>(_ objects: [T], completion: DBOperationCompletion?)
    func asyncRead<T>(_ request: FetchRequest<T>, completion: @escaping DBOperationCompletion)
    func asyncDelete<T: Stored>(_ objects: [T], completion: DBOperationCompletion?)
    
    // MARK: - Drop data base
    
    func dropDataBaseIfExists() -> Error?
    
}

extension DataBaseService {
    
    func findFirst<T: Stored>(_ type: T.Type, primaryValue: String, predicate: NSPredicate? = nil) -> Stored? {
        guard let primaryKey = type.primaryKey else {
            return nil
        }
        
        let primaryKeyPredicate = NSPredicate(format: "\(primaryKey) == %@", primaryValue)
        var fetchPredicate: NSPredicate
        if let predicate = predicate {
            fetchPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [primaryKeyPredicate, predicate])
        } else {
            fetchPredicate = primaryKeyPredicate
        }
        
        let request = FetchRequest<T>(predicate: fetchPredicate, fetchLimit: 1)
        
        return read(request).objects?.first
    }
    
    func asyncFindFirst<T: Stored>(_ type: T.Type, primaryValue: String, predicate: NSPredicate? = nil, completion: @escaping DBOperationCompletion) {
        
        guard let primaryKey = type.primaryKey else {
            return
        }
        
        let primaryKeyPredicate = NSPredicate(format: "\(primaryKey) == %@", primaryValue)
        var fetchPredicate: NSPredicate
        if let predicate = predicate {
            fetchPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [primaryKeyPredicate, predicate])
        } else {
            fetchPredicate = primaryKeyPredicate
        }
        
        let request = FetchRequest<T>(predicate: fetchPredicate, fetchLimit: 1)
        
        asyncRead(request, completion: completion)
    }
    
    func fetchAll<T: Stored>(_ type: T.Type) -> DBOperationResult {
        return read(FetchRequest<T>())
    }
    
    func asyncFetchAll<T>(_ type: T.Type, fetchRequest: FetchRequest<T>? = nil, completion: @escaping DBOperationCompletion) {
        asyncRead(FetchRequest<T>(), completion: completion)
    }
    
}
