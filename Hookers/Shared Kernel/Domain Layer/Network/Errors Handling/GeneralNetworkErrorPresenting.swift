//
//  GeneralNetworkErrorPresenting.swift
//  Privat24
//
//  Created by Maxim Letushov on 6/6/17.
//  Copyright © 2017 Privat24. All rights reserved.
//

import Foundation

protocol GeneralNetworkErrorPresenting {
    
    func presentGeneralNetworkError(_ error: GeneralNetworkPresentingError)
    
}
