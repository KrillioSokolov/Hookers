//
//  HookahMix.swift
//  Hookers
//
//  Created by Kirill Sokolov on 22.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct HookahMix: Codable {
    
    struct Tabacco: Codable {
        
        let brand: String
        let sort: String
        
    }
    
    let mixId: String
    let name: String
    let imageURL: String
    let price: Double
    let categoryId: String
    let restaurantId: String
    var strenght: String
    var likes: Int
    var tabacco: [HookahMix.Tabacco]
    var description: String
    let hookahBowl: String?
    let filling: String?

}

