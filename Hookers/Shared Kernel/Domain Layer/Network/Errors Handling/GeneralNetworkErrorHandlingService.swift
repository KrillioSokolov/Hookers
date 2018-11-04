//
//  GeneralNetworkErrorHandlingService.swift
//  Privat24
//
//  Created by Maxim Letushov on 6/6/17.
//  Copyright © 2017 Privat24. All rights reserved.
//

import Foundation

final class GeneralNetworkErrorHandlingService {
    
    fileprivate let errorPresenter: GeneralNetworkErrorPresenting
    
    init(errorPresenter: GeneralNetworkErrorPresenting) {
        self.errorPresenter = errorPresenter
    }
    
    func presentingErrorFromResponse(_ response: NetworkResponse?) -> GeneralNetworkPresentingError? {
        if let urlError = response?.error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet,
                 .networkConnectionLost:
                return .noInternetConnection
                
            default:
                return .somethingWentWrong
            }
        }
        
        if response?.error is ResponseMappingError {
            return .somethingWentWrong
        }
        
        if let httpStatusCode = response?.httpStatusCode {
            switch httpStatusCode {
            case HTTPStatusCode.unauthorized_401:
                return .unauthorized
            case HTTPStatusCode.forbidden_403:
                return .forbidden
            case 400...499:
                return .somethingWentWrong
            case 500...599:
                return .serverIsNotAvailable
            default:
                break
            }
        }
        
        if response?.result == .error {
            return .innerServerError
        }
        
        return nil
    }
}

extension GeneralNetworkErrorHandlingService: NetworkErrorHandling {
    
    func handleErrorInNetworkResponse(_ response: NetworkResponse?) {
        let presentingError = presentingErrorFromResponse(response)
        if let presentingError = presentingError {
            errorPresenter.presentGeneralNetworkError(presentingError)
        }
    }
    
}
