//
//  OrdersStore.swift
//  Hookers
//
//  Created by Chelak Stas on 11/18/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct OrdersListStoreStateChange: OptionSet, DataStateChange {
    
    let rawValue: Int
    
    static let isLoadingState = OrdersListStoreStateChange(rawValue: Int.bit1)
    static let orders = OrdersListStoreStateChange(rawValue: Int.bit2)
    
}

final class OrdersListStore: DomainModel {
    
    let networkService: OrdersNetwork
    let dispatcher: Dispatcher
    
    private(set) var orders: [NetworkOrder]?
//    private(set) var hookahMenuData: HookahMenuResponse.Data?
//    private(set) var hookahMastersData: HookahMastersListResponse.Data?
//    private(set) var hookahOrderResponseData: HookahOrderResponse.Data?
    
//    private(set) var orderedMixes: [HookahMix] = []
    
    private(set) var isLoading = false
    
    init(networkService: OrdersNetwork, dispatcher: Dispatcher) {
        self.networkService = networkService
        self.dispatcher = dispatcher
    }
    
}

extension OrdersListStore {
    
    func getOrdersList() {
        startLoading()

        taskDispatcher.dispatch {
            self.networkService.getOrdersList(with: "3", completion: { (networkResponse, ordersListResponse) in
                self.changeDataStateOf([.orders, .isLoadingState] as OrdersListStoreStateChange, work: {
                    self.isLoading = false
                    
                    self.orders = ordersListResponse?.data.ordersList
                })
            })
        }
    }
    
}

extension OrdersListStore {
    
    func startLoading() {
        changeDataStateOf(OrdersListStoreStateChange.isLoadingState) {
            isLoading = true
        }
    }
    
}
