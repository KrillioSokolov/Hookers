//
//  BaseNetworkService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

protocol BaseNetworkService: class {
    
    var networkService: HTTPNetworkService { get }
    
}
