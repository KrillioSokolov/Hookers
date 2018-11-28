//
//  NetworkOrdersListResponse.swift
//  Hookers
//
//  Created by Chelak Stas on 11/18/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct NetworkOrdersListResponse: Decodable {
    
    struct Data: Decodable {
        
        let ordersList: [NetworkArchivedOrder]
        
    }
    
    let reqId: String
    let action: String
    let data: NetworkOrdersListResponse.Data
    
}
