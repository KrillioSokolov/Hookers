//
//  RestaurantsEvent.swift
//  Hookers
//
//  Created by Kirill Sokolov on 30.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct RestaurantsEvent {
    
    struct NavigationEvent {
        
        struct CloseScreen: Event {
            typealias Payload = Value
            
            struct Value {
                let animated: Bool
            }
            
        }
        
        struct DidChooseRestaurant: Event {
            typealias Payload = Value
            
            struct Value {
                let restaurant: NetworkRestaurant
            }
        }
        
        struct DidTapInfoButtonOnRestaurantCell: Event {
            typealias Payload = Value
            
            struct Value {
                let restaurant: NetworkRestaurant
            }
        }
        
    }
    
}
