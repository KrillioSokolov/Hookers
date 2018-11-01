//
//  HookahMasterListResponse.swift
//  Hookers
//
//  Created by Kirill Sokolov on 31.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct HookahMastersListResponse {
    
    struct Data: Codable {
        let restaurantId: String?
        let hookahMasters: [HookahMaster]
    }
    
    let action: String
    let data: HookahMastersListResponse.Data
    
}
