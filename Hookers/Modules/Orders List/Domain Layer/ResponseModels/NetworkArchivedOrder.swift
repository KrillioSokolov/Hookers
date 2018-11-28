//
//  NetworkOrder.swift
//  Hookers
//
//  Created by Chelak Stas on 11/18/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct NetworkArchivedOrder: Decodable {
    
    let clientName: String
    let phoneNumber: String
    let hookahMasterId: String
    let orderId: String
    let dueDate: String
    let condition: String
    let hookahs: [HookahMix]
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
    
}

