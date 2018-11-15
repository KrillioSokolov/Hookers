//
//  RestaurantResponse.swift
//  Hookers
//
//  Created by Kirill Sokolov on 04.11.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation



struct RestaurantResponse: RestResponse {
    
    let action: String
    let data: Codable & Any
    
}

protocol RestResponse {
    
    var action: String { get }
    var data: Codable & Any { get }
    
}
