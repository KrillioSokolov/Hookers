//
//  HookahMaster.swift
//  Hookers
//
//  Created by Kirill Sokolov on 22.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct HookahMaster: DisplayableRestaurantListItem {
    
    var name: String
    var photo: String
    var likes: String
    var distanse: String
    var masterId: String
 
    static func testMasters() -> [HookahMaster] {
        
        let nikolay = HookahMaster(name: "Николай", photo: "kolaHabl-1", likes: "1465/1745", distanse: "11", masterId: "kolya")
        let salyam = HookahMaster(name: "Дмитрий", photo: "salyam", likes: "816/1142", distanse: "16", masterId: "salyam")
        let hooka1 = HookahMaster(name: "Михей", photo: "hooker1", likes: "2432/2567", distanse: "3", masterId: "mixey")
        let hooka2 = HookahMaster(name: "Ростислав", photo: "hooker2", likes: "1083/1694", distanse: "9", masterId: "hookah2")
        let hookah3 = HookahMaster(name: "Алиса", photo: "hooka3", likes: "9991/1163", distanse: "7", masterId: "blowjob")
        
        return [nikolay, salyam, hookah3, hooka1, hooka2]
        
    }
    
}