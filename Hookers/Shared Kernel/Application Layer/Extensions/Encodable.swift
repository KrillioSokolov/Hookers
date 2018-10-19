//
//  Encodable.swift
//  Hookers
//
//  Created by Sokolov Kirill on 3/26/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}
