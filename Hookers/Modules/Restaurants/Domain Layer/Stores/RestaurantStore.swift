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
    static let hookahMenu = RestaurantStoreStateChange(rawValue: Int.bit3)
    
}

final class RestaurantStore: DomainModel {
    
    let networkService: RestaurantNetwork
    let dispatcher: Dispatcher
    
    var restaurants: [NetworkRestaurant]?
    var hookahMenu: HookahMenuResponse.Data?
    
    var isLoading = false
    
    
    init(networkService: RestaurantNetwork, dispatcher: Dispatcher) {
        self.networkService = networkService
        self.dispatcher = dispatcher
    }
    
}

extension RestaurantStore {
    
    func getRestaurantsList() {
        startLoading()
        
        networkService.getRestaurantList { (networkResponse, restaurantListResponse) in
            self.changeDataStateOf([.restaurants, .isLoadingState] as RestaurantStoreStateChange, work: {
                self.isLoading = false
                
                guard let restaurantListResponse = restaurantListResponse else { return }
                self.restaurants = restaurantListResponse.data.restaurants
            })
        }
    }
    
    func getHookahMenu(byRestaurantId restaurantId: String) {
        startLoading()
        
        networkService.getHookahMenu(byRestaurantId: restaurantId) { (networkResponse, hookahMenuResponse) in
            self.changeDataStateOf([.hookahMenu, .isLoadingState] as RestaurantStoreStateChange, work: {
                self.isLoading = false
                
                self.hookahMenu = hookahMenuResponse?.data
            })
        }
    }
    
}

extension RestaurantStore {
    
    func startLoading() {
        changeDataStateOf(RestaurantStoreStateChange.isLoadingState) {
            isLoading = true
        }
    }
        
}
