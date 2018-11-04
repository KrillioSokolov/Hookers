//
//  RestaurantNetworkService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation


protocol RestaurantNetwork {
    
    func getRestaurantList(with completion: @escaping ((NetworkResponse?, NetworkRestaurantsListResponse?) -> Void))
    func getHookahMenu(byRestaurantId restaurantId: String, with completion: @escaping ((NetworkResponse?, HookahMenuResponse?) -> Void))
    func getHookahMastersList(byRestaurantId restaurantId: String?, with completion: @escaping ((NetworkResponse?, HookahMastersListResponse?) -> Void))
    func makeHookahOrder(_ hookahOrder: HookahOrder, with completion: @escaping ((NetworkResponse?, HookahOrderResponse?) -> Void))
    
}

final class RestaurantNetworkService: BaseNetworkService, RestaurantNetwork {
    
    let networkService: HTTPNetworkService
    
    init(networkService: HTTPNetworkService) {
        self.networkService = networkService
    }
    
    func getRestaurantList(with completion: @escaping ((NetworkResponse?, NetworkRestaurantsListResponse?) -> Void)) {
        networkService.executeRequest(endpoint: "restaurantsList", method: .get, parameters: nil, headers: nil, completion: completion)
    }
    
    func getHookahMenu(byRestaurantId restaurantId: String, with completion: @escaping ((NetworkResponse?, HookahMenuResponse?) -> Void)) {
        let parametrs = [ "restaurantId" : restaurantId ] as Parameters
        
        networkService.executeRequest(endpoint: "hookahMenu", method: .get, parameters: parametrs, headers: nil, completion: completion)
    }
    
    func getHookahMastersList(byRestaurantId restaurantId: String? = nil, with completion: @escaping ((NetworkResponse?, HookahMastersListResponse?) -> Void)) {
        var parametrs: Parameters?
        
        if let restaurantId = restaurantId {
            parametrs = [ "restaurantId" : restaurantId ]
        }
        
        networkService.executeRequest(endpoint: "hookahMastersList", method: .get, parameters: parametrs, headers: nil, completion: completion)
    }
    
    func makeHookahOrder(_ hookahOrder: HookahOrder, with completion: @escaping ((NetworkResponse?, HookahOrderResponse?) -> Void)) {
        networkService.executeRequest(endpoint: "makeOrder", method: .get, parameters: hookahOrder.dictionary, headers: nil, completion: completion)
    }
    
}
