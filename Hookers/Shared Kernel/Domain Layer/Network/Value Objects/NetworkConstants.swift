//
//  NetworkConstants.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    static var devServerBaseURL: URL {
        return NetworkConstants.kirillNgrokURL
    }
    static let kirillNgrokURL = URL(string: "http://46738d97.ngrok.io/")!
    static let nikaNgrokURL = URL(string: "https://a72eac1c.ngrok.io/")!
    static let localHostUrl = URL(string: "http://localhost:8081/")!
    static let prodServerURL = ""
    
}
