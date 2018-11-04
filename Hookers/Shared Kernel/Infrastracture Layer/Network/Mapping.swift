//
//  Mapping.swift
//  Network
//
//  Created by Maxim Letushov on 5/25/17.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol Mapping { }    //just a marker protocol

protocol MappingToJSON: Mapping {
    
    associatedtype MappableToJSON
    
    static func anyToJSON(_ any: MappableToJSON) -> JSON?
    static func collectionToJSON(_ collection: [MappableToJSON]) -> [JSON]
    static func collectionToJSONIgnoringNil(_ collection: [MappableToJSON]) -> [JSON]
    
}

extension MappingToJSON {
    
    static func collectionToJSON(_ collection: [MappableToJSON]) -> [JSON] {
        return collection.map { anyToJSON($0)! }
    }
    
    static func collectionToJSONIgnoringNil(_ collection: [MappableToJSON]) -> [JSON] {
        return collection.compactMap { anyToJSON($0) }
    }
    
}

protocol MappingFromJSON: Mapping {
    
    associatedtype MappableFromJSON
    
    static func JSONtoAny(_ json: JSON) -> MappableFromJSON?
    static func JSONToCollection(_ jsonCollection: [JSON]) -> [MappableFromJSON]
    static func JSONToCollectionIgnoringNil(_ jsonCollection: [JSON]) -> [MappableFromJSON]
    
}


extension MappingFromJSON {
    
    static func JSONToCollection(_ jsonCollection: [JSON]) -> [MappableFromJSON] {
        return jsonCollection.compactMap { JSONtoAny($0) }
    }
    
    static func JSONToCollectionIgnoringNil(_ jsonCollection: [JSON]) -> [MappableFromJSON] {
        return jsonCollection.compactMap { JSONtoAny($0) }
    }
    
}
