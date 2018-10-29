//
//  NetworkRestaurant.swift
//  Hookers
//
//  Created by Kirill Sokolov on 20.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct NetworkRestaurant: DisplayableRestaurantListItem, Decodable {

    let restaurantId: String
    var name: String
    var likes: Int
    //let address: NetworkAdress
    let workTimeDescription: String
    let description: String
    let photos: [String]
    var distanse: String {
        return String(Int(arc4random_uniform(100)))
    }
    var photo: String {
        return photos.first!
    }
    
    static func makeTestRestaurants() -> [NetworkRestaurant] {
        
//        let rest1 = NetworkRestaurant(restaurantId: 1, name: "Hookah Place", likes: "4.73", workTimeString: "11:00 - 23:00", description: "Описание", photos: ["rest_default"], distanse: "11")
//
//        let rest2 = NetworkRestaurant(restaurantId: "2", name: "Хабл Бабл", likes: "4.66", workTimeString: "11:00 - 02:00", description: "Описание", photos: ["habl"], distanse: "19")
//
//        let rest3 = NetworkRestaurant(restaurantId: "3", name: "Голый Шеф", likes: "4.61", workTimeString: "11:00 - 23:00", description: "Описание", photos: ["goliyshef"], distanse: "9")
//
//        let rest4 = NetworkRestaurant(restaurantId: "4", name: "Паровоз", likes: "4.54", workTimeString: "11:00 - 00:00", description: "Описание", photos: ["parovoz"], distanse: "14")
//
//        let rest5 = NetworkRestaurant(restaurantId: "5", name: "Четверги", likes: "4.38", workTimeString: "19:00 - 06:00", description: "Описание", photos: ["chetvergi"], distanse: "6")
//
//
//        return [rest1, rest2, rest3, rest4, rest5]
        
        return []
    }
    
}
