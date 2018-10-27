//
//  NetworkResponseInnerError.swift
//  channels-ios
//
//  Created by Roman Scherbakov on 12/20/17.
//  Copyright © 2017 Приват24. All rights reserved.
//

import Foundation

final class NetworkResponseInnerError: Error {
    
    let reqId: String
    let code: String?
    let description: String?
    
    init(reqId: String, code: String?, description: String?) {
        self.reqId = reqId
        self.code = code
        self.description = description
    }
    
}
