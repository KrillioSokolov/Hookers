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
    static let bestHookahMasters = RestaurantStoreStateChange(rawValue: Int.bit4)
    static let hookahMastersForRestaurant = RestaurantStoreStateChange(rawValue: Int.bit5)
    
}

final class RestaurantStore: DomainModel {
    
    let networkService: RestaurantNetwork
    let dispatcher: Dispatcher
    
    private(set) var restaurants: [NetworkRestaurant]?
    private(set) var hookahMenuData: HookahMenuResponse.Data?
    private(set) var hookahMastersData: HookahMastersListResponse.Data?
    
    private(set) var isLoading = false
    
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
                
                self.hookahMenuData = hookahMenuResponse?.data
            })
        }
    }
    
    func getHookahMastersList(restaurantId: String? = nil) {
        startLoading()
        
        networkService.getHookahMastersList(byRestaurantId: restaurantId) { (networkReponse, hookahMastersListResponse) in
            guard let hookahMastersListResponse = hookahMastersListResponse else { return }
            
            let changeType: RestaurantStoreStateChange
            
            if hookahMastersListResponse.data.restaurantId != nil {
                changeType = .hookahMastersForRestaurant
            } else {
                //KS: TODO: Change when server will be ready
                changeType = .bestHookahMasters
            }
            
            self.changeDataStateOf([changeType, .isLoadingState] as RestaurantStoreStateChange, work: {
                self.isLoading = false
                self.hookahMastersData = hookahMastersListResponse.data
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
