//
//  RestaurantStore.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct RestaurantStoreStateChange: OptionSet, DataStateChange {
    
    let rawValue: Int
    
    static let isLoadingState = RestaurantStoreStateChange(rawValue: Int.bit1)
    static let restaurants = RestaurantStoreStateChange(rawValue: Int.bit2)
    
}

final class RestaurantStore: DomainModel {
    
    var networkService: RestaurantNetwork
    let dispatcher: Dispatcher
    var restaurants: [NetworkRestaurant] = []
    
    var isLoading = false
    
    
    init(networkService: RestaurantNetwork, dispatcher: Dispatcher) {
        
        self.networkService = networkService
        self.dispatcher = dispatcher
        
    }
    
}

extension RestaurantStore {
    
    func startLoading() {
        changeDataStateOf(RestaurantStoreStateChange.isLoadingState) {
            isLoading = true
        }
    }
    
    func getRestaurantsList() {
        startLoading()
        
        networkService.getRestaurantList { (networkResponse, restaurantListResponse) in
            guard let restaurantListResponse = restaurantListResponse else { return }
            
            self.changeDataStateOf([.restaurants, .isLoadingState] as RestaurantStoreStateChange, work: {
                self.isLoading = false
                self.restaurants = restaurantListResponse.data.restaurants
            })
        }
    }
    
}
