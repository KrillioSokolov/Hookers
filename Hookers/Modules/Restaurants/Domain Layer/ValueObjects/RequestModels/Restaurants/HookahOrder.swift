//
//  HookahOrder.swift
//  Hookers
//
//  Created by Kirill Sokolov on 04.11.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct HookahOrder: Codable {
    
    let clientId: String
    let clientName: String
    let phoneNumber: String
    let peopleCount: Int
    let hookahMastersId: String
    let tableNumber: Int?
    let restaurantId: String
    let dueDate: String
    let mixes: [HookahMix]
    
}
