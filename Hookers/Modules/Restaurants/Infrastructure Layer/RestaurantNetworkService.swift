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
    
}

final class RestaurantNetworkService: BaseNetworkService, RestaurantNetwork {
    let networkService: HTTPNetworkService
    
    init(networkService: HTTPNetworkService) {
        self.networkService = networkService
    }
    
    func getRestaurantList(with completion: @escaping ((NetworkResponse?, NetworkRestaurantsListResponse?) -> Void)) {
        networkService.executeRequest(endpoint: "restaurantsList", method: .get, parameters: nil, headers: nil) { networkResponse in
            
            guard let action = networkResponse.action,
                let data = networkResponse.data,
                let decodedResponse = try? JSONDecoder().decode(NetworkRestaurantsListResponse.Data.self, from: data)
                else {
                    completion(networkResponse, nil)
                    return
                }
            
            let networkRestaurantListResponse = NetworkRestaurantsListResponse(action: action, data: decodedResponse)
    
            completion(networkResponse, networkRestaurantListResponse)
        }
    }
    
    func getHookahMenu(byRestaurantId restaurantId: String, with completion: @escaping ((NetworkResponse?, HookahMenuResponse?) -> Void)) {
        let parametrs = [ "restaurantId" : restaurantId ] as Parameters
        
        networkService.executeRequest(endpoint: "hookahMenu", method: .get, parameters: parametrs, headers: nil) { (networkResponse) in
            guard let action = networkResponse.action,
                let data = networkResponse.data,
                let decodedResponse = try? JSONDecoder().decode(HookahMenuResponse.Data.self, from: data)
                else {
                    completion(networkResponse, nil)
                    return
                }
            
            let hookahMenuResponse = HookahMenuResponse(action: action, data: decodedResponse)
            
            completion(networkResponse, hookahMenuResponse)
        }
    }
    
}
