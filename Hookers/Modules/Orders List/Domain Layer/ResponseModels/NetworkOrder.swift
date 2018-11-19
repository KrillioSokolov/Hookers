//
//  NetworkOrder.swift
//  Hookers
//
//  Created by Chelak Stas on 11/18/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct NetworkOrder: Decodable {
    
    struct NetworkOrderHookah: Decodable {
        
        let name: String
        let mixId: String
        
    }
    
    let clientName: String
    let phoneNumber: String
    let hookahMasterId: String
    let orderId: String
    let dueDate: String
    let condition: String
    let hookahs: [NetworkOrderHookah]
    let clientId: String
    let restaurantId: String
    let peopleCount: String
    let payment: String
    let amount: String
    let tableNumber: String
    let hookahMasterName: String
    let hookahMasterImageURL: String
    let restaurantImageURL: String
    let restaurantName: String
    
    
//    static func makeTestOrders() -> [NetworkOrder] {
//        let order1 = NetworkOrder(clientName: "Name", phoneNumber: "", hookahMasterId: "", orderId: "", dueDate: "", condition: "", hookahs: [""], clientId: "", restaurantId: "", peopleCount: "", payment: "", amount: "", tableNumber: "")
//        
//        return [order1]
//    }
    
}

