//
//  OrdersNetworkService.swift
//  Hookers
//
//  Created by Chelak Stas on 11/18/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

protocol OrdersNetwork {
    
    func getOrdersList(with clientId: String, completion: @escaping ((NetworkResponse?, NetworkOrdersListResponse?) -> Void))
    
}

final class OrdersNetworkService: BaseNetworkService, OrdersNetwork {
    
    let networkService: HTTPNetworkService
    
    init(networkService: HTTPNetworkService) {
        self.networkService = networkService
    }
    
    func getOrdersList(with clientId: String, completion: @escaping ((NetworkResponse?, NetworkOrdersListResponse?) -> Void)) {
        let parameters = [ "clientId" : clientId ] as Parameters
        
        networkService.executeRequest(endpoint: "ordersList", method: .get, parameters: parameters, headers: nil, completion: completion)
    }
    
    
}


