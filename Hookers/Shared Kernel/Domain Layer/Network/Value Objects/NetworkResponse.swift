//
//  NetworkResponse.swift
//  Hookers
//
//  Created by Kirill Sokolov on 12/14/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation

enum ResultStatus: String, Decodable {
    
    case ok = "ok"
    case error = "error"

}

final class NetworkResponse: Decodable {

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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        result = try container.decodeWrapper(key: .result, defaultValue: nil)
        requestId = try container.decodeWrapper(key: .requestId, defaultValue: nil)
        networkInnerError = try container.decodeWrapper(key: .networkInnerError, defaultValue: nil)
        networkInnerError?.reqId = requestId
        action = try container.decodeWrapper(key: .action, defaultValue: nil)
        httpStatusCode = try container.decodeWrapper(key: .httpStatusCode, defaultValue: nil)
        
        error = nil
    }
    
    enum CodingKeys: String, CodingKey {
        
        case result, networkInnerError, requestId, action, data, httpStatusCode
        
    }

}

