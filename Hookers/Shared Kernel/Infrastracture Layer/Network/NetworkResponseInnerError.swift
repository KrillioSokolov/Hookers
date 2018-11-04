//
//  NetworkResponseInnerError.swift
//  Hookers
//
//  Created by Sokolov Kirill on 12/20/17.
//  Copyright © 2017 Приват24. All rights reserved.
//

import Foundation

final class NetworkResponseInnerError: Error, Codable {
    
    var reqId: String!
    let errCode: String?
    let errDescr: String?
    
    init(reqId: String, code: String?, description: String?) {
        self.reqId = reqId
        self.errCode = code
        self.errDescr = description
    }
    
}
