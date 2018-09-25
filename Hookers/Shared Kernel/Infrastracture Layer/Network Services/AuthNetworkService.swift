//
//  AuthNetworkService.swift
//  channels-ios
//
//  Created by Sokolov Kirill on 3/26/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import Foundation

protocol AuthNetwork {
    
    func tokenCreate<T>(encodeRequest: T, withCompletion completion: @escaping (_ tokenCreateResponse: NetworkTokenCreateResponse?, _ networkResponse: NetworkResponse?) -> Void) where T: Encodable
    
}

final class AuthNetworkService: AuthNetwork {
    
    private var httpNetworkService: HTTPNetworkService
    
    init(httpNetworkService: HTTPNetworkService) {
        self.httpNetworkService = httpNetworkService
    }
    
    func tokenCreate<T>(encodeRequest: T, withCompletion completion: @escaping (_ tokenCreateResponse: NetworkTokenCreateResponse?, _ networkResponse: NetworkResponse?) -> Void) where T: Encodable {
        if let encodedData = try? JSONEncoder().encode(encodeRequest),
            let jsonString = String(data: encodedData, encoding: .utf8),
            let parametrs = String.convertToDictionary(text: jsonString) {
            print("http request = \(jsonString)")
            httpNetworkService.executeRequest(endpoint: "/token", method: .post, parameters: parametrs) { response in
                var tokenCreateResponse: NetworkTokenCreateResponse?
                if response.result == .ok, let data = response.data {
                    tokenCreateResponse = try? JSONDecoder().decode(NetworkTokenCreateResponse.self,
                                                                    from: data)
                }
                completion(tokenCreateResponse, response)
            }
        }
    }
    
}
