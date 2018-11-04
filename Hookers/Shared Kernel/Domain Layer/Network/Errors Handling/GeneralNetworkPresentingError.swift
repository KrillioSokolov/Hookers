//
//  GeneralNetworkPresentingError.swift
//  Privat24
//
//  Created by Maxim Letushov on 6/6/17.
//  Copyright © 2017 Privat24. All rights reserved.
//

import Foundation

enum GeneralNetworkPresentingError {
    
    case unauthorized
    case forbidden
    case noInternetConnection
    case serverIsNotAvailable
    case somethingWentWrong
    case innerServerError
    
    //ML: TODO: implement handling for cases below
    case appVersionIsDeprecated     //you can use application but updation is highly recommended
    case unsupportedAppVersion      //you have to update application
    
}
