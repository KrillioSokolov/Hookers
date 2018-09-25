//
//  CoreDataModelConvertible.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import CoreData

protocol CoreDataModelConvertible: Stored, NSManagedObjectToStoredMapping, StoredToNSManagedObjectMapping {}

protocol NSManagedObjectToStoredMapping {
    
    static func mapToStored(fromManagedObject managedObject: NSManagedObject) -> Stored
    static func managedObjectClass() -> NSManagedObject.Type
    
}

protocol StoredToNSManagedObjectMapping {
    
    static var entityName: String { get }
    
    @discardableResult
    func mapToNSManagedObject(withManagedObject managedObject: NSManagedObject, context: NSManagedObjectContext) -> NSManagedObject
    
}
