//
//  MixCategory.swift
//  Hookers
//
//  Created by Kirill Sokolov on 22.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct MixCategory: Codable {
    
    let categoryId: String
    let name: String
    let imageURL: String
    let likes: String
    let description: String
    let mixes: [HookahMix]
    
}
