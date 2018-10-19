//
//  Result.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/7/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
    
}

extension Result {
    
    init(value: T?, error: Error? = nil) {
        switch (value, error) {
        case (let v?, _):
            self = .success(v)
        case (nil, let e?):
            self = .failure(e)
        case (nil, nil):
            let error = NSError(domain: "ResultErrorDomain", code: 1,
                                userInfo: [NSLocalizedDescriptionKey:
                                    "Invalid input: value and error were both nil."])
            self = .failure(error)
        }
    }
    
}
