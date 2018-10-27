//
//  RestaurantStore.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

final class RestaurantStore {
    
    var networkService: RestaurantNetworkService
    let dispatcher: Dispatcher
    
    init(networkService: RestaurantNetworkService, dispatcher: Dispatcher) {
        
        self.networkService = networkService
        self.dispatcher = dispatcher
        
    }
    
    func getRestaurantsList() {
        
        networkService.getRestaurantList { (response, responseModel) in
            print(responseModel)
        }
    }
    
}
