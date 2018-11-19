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
        return NetworkConstants.stasNgrokURL
    }
    static let kirillNgrokURL = URL(string: "http://c87a500f.ngrok.io/")!
    static let nikaNgrokURL = URL(string: "https://a72eac1c.ngrok.io/")!
    static let stasNgrokURL = URL(string: "https://0938f7fa.ngrok.io/")!
    static let localHostUrl = URL(string: "http://localhost:8081/")!
    static let prodServerURL = ""
    
}
