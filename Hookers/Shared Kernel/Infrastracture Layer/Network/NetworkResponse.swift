//
//  NetworkResponse.swift
//  Hookers
//
//  Created by Kirill Sokolov on 12/14/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation

enum ResultStatus {
    
    case ok
    case error

}

final class NetworkResponse {

    var result: ResultStatus?
    var networkInnerError: NetworkResponseInnerError?
    var requestId: String?
    var action: String?
    var data: Data?

    let httpStatusCode: Int?
    let error: Error?

    init(result: ResultStatus?, networkInnerError: NetworkResponseInnerError?, requestId: String?, action: String?, data: Data?, httpStatusCode: Int?, error: Error?) {
        self.result = result
        self.networkInnerError = networkInnerError
        self.requestId = requestId
        self.action = action
        self.data = data
        self.httpStatusCode = httpStatusCode
        self.error = error
    }

}

