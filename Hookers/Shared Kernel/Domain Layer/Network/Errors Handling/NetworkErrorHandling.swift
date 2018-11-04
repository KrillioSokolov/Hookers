//
//  NetworkErrorHandling.swift
//  Privat24
//
//  Created by Maxim Letushov on 6/2/17.
//  Copyright © 2017 Privat24. All rights reserved.
//

import Foundation

struct GeneralNetworkError: Error {}

protocol NetworkErrorHandling: class {
    
    func handleErrorInNetworkResponse(_ response: NetworkResponse?)
    
    func isInternetConnectionErrorInResponse(_ response: NetworkResponse?) -> Bool
    
    func isTimedOutInResponse(_ response: NetworkResponse?) -> Bool
    
    func errorInNetworkResponse(_ response: NetworkResponse?) -> Error?
    
}

extension NetworkErrorHandling {
    
    func isInternetConnectionErrorInResponse(_ response: NetworkResponse?) -> Bool {
        if let urlError = response?.error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet,
                 .networkConnectionLost:
                return true
            default:
                break
            }
        }
        
        return false
    }
    
    func isTimedOutInResponse(_ response: NetworkResponse?) -> Bool {
        if let urlError = response?.error as? URLError {
            return urlError.code == .timedOut
        }
        
        return false
    }
    
    func errorInNetworkResponse(_ response: NetworkResponse?) -> Error? {
        guard let response = response else { return GeneralNetworkError() }
        return response.result == .ok ? nil : response.error ?? GeneralNetworkError()
    }
    
}
