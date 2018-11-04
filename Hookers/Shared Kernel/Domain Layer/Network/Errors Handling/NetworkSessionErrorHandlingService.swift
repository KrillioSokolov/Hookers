//
//  NetworkSessionErrorHandlingService.swift
//  Privat24
//
//  Created by Maxim Letushov on 5/30/17.
//  Copyright © 2017 Privat24. All rights reserved.
//

import Foundation

final class NetworkSessionErrorHandlingService { }

extension NetworkSessionErrorHandlingService: NetworkErrorHandling {
 
    func handleErrorInNetworkResponse(_ response: NetworkResponse?) {
        guard let httpStatusCode = response?.httpStatusCode else {
            return
        }
        
        switch httpStatusCode {
        case HTTPStatusCode.unauthorized_401:
            print("unauthorized 401")
        case HTTPStatusCode.forbidden_403:
            print("forbidden 403")
        default:
            break
        }
    }
    
}
