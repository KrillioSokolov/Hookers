//
//  ResponseModel.swift
//  Hookers
//
//  Created by Kirill Sokolov on 26.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct ResponseModel: Decodable {
    
    let action: String
    let data: Data
    
}
