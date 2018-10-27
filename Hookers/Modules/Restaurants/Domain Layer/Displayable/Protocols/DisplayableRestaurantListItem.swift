//
//  DisplayableRestaurantListItem.swift
//  Hookers
//
//  Created by Kirill Sokolov on 27.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

protocol DisplayableRestaurantListItem {
    
    var photo: String { get }
    var name: String { get }
    var distanse: String { get }
    var likes: String { get }
    
}
