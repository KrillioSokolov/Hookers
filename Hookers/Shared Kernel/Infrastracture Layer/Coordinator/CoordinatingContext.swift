//
//  CoordinatingContext.swift
//  ClearMVC
//
//  Created by Sokolov Kirill on 5/2/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

final class CoordinatingContext {
    
    let dispatcher: Dispatcher
    var dataBaseService: CoreDataDBService?
    let styleguide: DesignStyleGuide
    
    let cache = NSCache<NSString, AnyObject>() //IM: TODO: content undependenced with user
    
    init(dispatcher: Dispatcher, styleguide: DesignStyleGuide) {
        self.styleguide = styleguide
        self.dispatcher = dispatcher
    }
    
}
