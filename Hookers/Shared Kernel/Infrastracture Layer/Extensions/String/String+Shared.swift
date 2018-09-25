//
//  String+Shared.swift
//  Hookers
//
//  Created by Maksym Letiushov on 03.07.2018.
//  Copyright © 2018 Приват24. All rights reserved.
//

import Foundation

extension String {
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
