//
//  FetchRequest.swift
//  CoreDataMultipleVersions
//
//  Created by Sokolov Kirill on 12/4/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

// RS TODO: possibly in future remove generic type in this class

struct FetchRequest<T: Stored> {
    
    let sortDescriptor: NSSortDescriptor?
    let predicate: NSPredicate?
    let fetchOffset: Int
    let fetchLimit: Int
    
    init(predicate: NSPredicate? = nil, sortDescriptor: NSSortDescriptor? = nil, fetchOffset: Int = 0, fetchLimit: Int = 0) {
        self.predicate = predicate
        self.sortDescriptor = sortDescriptor
        self.fetchOffset = fetchOffset
        self.fetchLimit = fetchLimit
    }
    
}

// MARK: - Filtering

extension FetchRequest {
    
    func filtered(with predicate: NSPredicate) -> FetchRequest<T> {
        return request(withPredicate: predicate)
    }
    
    func filtered(with key: String, equalTo value: String) -> FetchRequest<T> {
        return request(withPredicate: NSPredicate(format: "\(key) == %@", value))
    }
    
    func filtered(with key: String, in value: [String]) -> FetchRequest<T> {
        return request(withPredicate: NSPredicate(format: "\(key) IN %@", value))
    }
    
    func filtered(with key: String, notIn value: [String]) -> FetchRequest<T> {
        return request(withPredicate: NSPredicate(format: "NOT (\(key) IN %@)", value))
    }
    
}

// MARK: - Sorting

extension FetchRequest {
    
    func sorted(with sortDescriptor: NSSortDescriptor) -> FetchRequest<T> {
        return request(withSortDescriptor: sortDescriptor)
    }
    
    func sorted(with key: String?, ascending: Bool, comparator cmptr: @escaping Comparator) -> FetchRequest<T> {
        return request(withSortDescriptor: NSSortDescriptor(key: key, ascending: ascending, comparator: cmptr))
    }
    
    func sorted(with key: String?, ascending: Bool) -> FetchRequest<T> {
        return request(withSortDescriptor: NSSortDescriptor(key: key, ascending: ascending))
    }
    
    func sorted(with key: String?, ascending: Bool, selector: Selector) -> FetchRequest<T> {
        return request(withSortDescriptor: NSSortDescriptor(key: key, ascending: ascending, selector: selector))
    }
    
}

// MARK: - Private

private extension FetchRequest {
    
    func request(withPredicate predicate: NSPredicate) -> FetchRequest<T> {
        return FetchRequest<T>(
            predicate: predicate,
            sortDescriptor: sortDescriptor,
            fetchOffset: fetchOffset,
            fetchLimit: fetchLimit
        )
    }
    
    func request(withSortDescriptor sortDescriptor: NSSortDescriptor) -> FetchRequest<T> {
        return FetchRequest<T>(
            predicate: predicate,
            sortDescriptor: sortDescriptor,
            fetchOffset: fetchOffset,
            fetchLimit: fetchLimit
        )
    }
    
}

