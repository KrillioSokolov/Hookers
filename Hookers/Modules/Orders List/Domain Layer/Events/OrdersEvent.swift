//
//  OrdersEvent.swift
//  Hookers
//
//  Created by Chelak Stas on 11/18/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct OrdersEvent {
    
    struct NavigationEvent {
        
        struct CloseScreen: Event {
            typealias Payload = Value
            
            struct Value {
                let animated: Bool
            }
            
        }
        
//        struct DidChooseOrder: Event {
//            typealias Payload = Value
//
//            struct Value {
//                let order: NetworkOrder
//            }
//        }
        
    }
    
}
