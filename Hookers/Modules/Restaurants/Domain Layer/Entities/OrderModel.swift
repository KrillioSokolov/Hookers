//
//  OrderModel.swift
//  Hookers
//
//  Created by Kirill Sokolov on 22.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct OrderModel {
    
    var price: Double
    var peopleCount: Int
    var date: String
    var mixes: [HookahMix]
    
    var restaurantId: String
    var hookahMasterId: String
    
}
