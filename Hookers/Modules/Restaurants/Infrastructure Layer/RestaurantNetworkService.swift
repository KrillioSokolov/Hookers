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
    
}

final class RestaurantNetworkService: BaseNetworkService, RestaurantNetwork {
    let networkService: HTTPNetworkService
    
    init(networkService: HTTPNetworkService) {
        self.networkService = networkService
    }
    
    func getRestaurantList(with completion: @escaping ((NetworkResponse?, NetworkRestaurantsListResponse?) -> Void)) {
        networkService.executeRequest(endpoint: "restaurantsList", method: .get, parameters: nil, headers: nil) { networkResponse in
            
//                guard let archiveData = try? JSONSerialization.data(withJSONObject: networkResponse.data, options: []) else { return }
//            let decodedResp = try? JSONDecoder().decode(NetworkRestaurantsListResponse.Data.self, from: networkResponse.data!)
//            
//            
//            print(decodedResp, decodedResp)
            
            completion(networkResponse, nil)
        }
    }
    
}
