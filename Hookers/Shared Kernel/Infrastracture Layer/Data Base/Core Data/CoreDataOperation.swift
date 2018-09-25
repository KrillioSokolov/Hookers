//
//  CoreDataStack.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import CoreData

protocol CoreDataOperation {
    
    func asyncCreateOrUpdate(withTask task: @escaping (NSManagedObjectContext) ->(), completion: @escaping (Error?) -> ())
    
    func read(withTask task: @escaping ((NSManagedObjectContext) -> ([NSManagedObject]?, Error?))) -> ([NSManagedObject]?, Error?)
    func asyncRead(withTask task: @escaping (NSManagedObjectContext) ->())
    
    func asyncDelete(withTask task: @escaping (NSManagedObjectContext) ->(), completion: @escaping (Error?) -> ())
    func delete(withTask task: @escaping (NSManagedObjectContext) ->()) -> Error?
    func count(withTask task: @escaping (NSManagedObjectContext) -> (Int?, Error?)) -> (Int?, Error?)
    
    func dropDataBaseIfExists() -> Error?
    
}
