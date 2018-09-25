//
//  CoordinatingContext.swift
//  ClearMVC
//
//  Created by Sokolov Kirill on 5/2/18.
//  Copyright © 2018 Privat24. All rights reserved.
//

import Foundation

final class CoordinatingContext {
    
    let dispatcher = DefaultDispatcher()
    var dataBaseService: CoreDataDBService?
    
    let cache = NSCache<NSString, AnyObject>() //IM: TODO: content undependenced with user
    
}
