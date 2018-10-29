//
//  HTTPStatusCode.swift
//  Hookers
//
//  Created by Kirill Sokolov on 6/1/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation

struct HTTPStatusCode {
    
    static let ok_200 = 200
    
    static let badRequest_400 = 400
    static let unauthorized_401 = 401
    static let forbidden_403 = 403
    static let notFound_404 = 404
    
    static let internalServerError_500 = 500
    static let gatewayTimeout_504 = 504
    static let insufficientStorage_507 = 507
    static let loopDetected_508 = 508
    static let unknownError_520 = 520
    static let connectionTimedOut_522 = 522
    static let timeoutOccurred_524 = 524
    
}
