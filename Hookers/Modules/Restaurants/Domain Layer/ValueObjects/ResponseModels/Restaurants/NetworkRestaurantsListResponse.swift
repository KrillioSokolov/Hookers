//
//  NetworkRestaurantsListResponse.swift
//  Hookers
//
//  Created by Kirill Sokolov on 20.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct NetworkRestaurantsListResponse: Decodable {
    
    let action: String
    let data: NetworkRestaurantsListResponse.Data
    
    struct Data: Decodable {
        
        let restaurants: [NetworkRestaurant]
        
    }
    
}
