//
//  NetworkResponseMapper.swift
//  Hookers
//
//  Created by Kirill Sokolov on 12/18/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import Foundation

final class NetworkResponseMapper {
    
    static func JSONtoAny(_ json: JSON) -> NetworkResponse? {
        guard let result = json["result"] as? String,
            let requestId = json["reqId"] as? String,
            let action = json["action"] as? String else {
            return nil
        }
        
        let data = try? JSONSerialization.data(withJSONObject: json["data"] ?? [:], options: [])
        
        let resultStatus: ResultStatus = (result == "ok") ? .ok : .error
        var networkError: NetworkResponseInnerError?
        
        if resultStatus == .error {
            let errorCode = json["errCode"] as? String
            let decription = json["errDescr"] as? String
            networkError = NetworkResponseInnerError(reqId: requestId, code: errorCode, description: decription)
        }

        
        return NetworkResponse(result: resultStatus, networkInnerError: networkError, requestId: requestId, action: action, data: data, httpStatusCode: nil, error: nil)
    }
    
}
