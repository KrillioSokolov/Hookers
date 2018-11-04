//
//  BaseNetworkService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 25.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation

typealias SuccessfulResponse<T: Decodable> = (action: String, decodedResponse: T)

protocol BaseNetworkService: class {
    
    var networkService: HTTPNetworkService { get }
    
    func makeResponse<T: Codable>(networkResponse: NetworkResponse, decodedType: T.Type, with completion: @escaping ((NetworkResponse?, SuccessfulResponse<T>?) -> Void))
    
}

extension BaseNetworkService {
    
    func makeResponse<T: Codable>(networkResponse: NetworkResponse, decodedType: T.Type, with completion: @escaping ((NetworkResponse?, SuccessfulResponse<T>?) -> Void)) {
        
        guard let action = networkResponse.action,
            let data = networkResponse.data,
            let decodedResponse = try? JSONDecoder().decode(T.self, from: data)
            else {
                completion(networkResponse, nil)
                return
        }
        
        completion(networkResponse, (action: action, decodedResponse: decodedResponse))
    }
    
}
