//
//  URLConvertible.swift
//  Hookers
//
//  Created by Kirill Sokolov on 5/26/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation

protocol URLConvertible {
    
    var asURL: URL { get }
    
}

extension URL: URLConvertible {
    
    var asURL: URL {
        return self
    }
    
}

extension String: URLConvertible {
    
    var asURL: URL {
        return URL(string: self)!
    }
    
}
