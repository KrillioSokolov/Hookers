//
//  UUID.swift
//  Hookers
//
//  Created by Sokolov Kirill on 2/28/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import Foundation

// Date from UUID
// https://gist.github.com/Frizlab/eee2ce3f1b6dc291c6744af53fca071f

extension UUID {
    
    var isTimeUUID: Bool {
        return (uuid.8 & 0xC0) == 0x80 && (uuid.6 & 0xF0) == 0x10
    }
    
    var generationDate: Date? {
        guard isTimeUUID else { return nil }
        
        let dateInt: UInt64 = (
            UInt64(uuid.3)        * 0x1 +
                UInt64(uuid.2)        * 0x100 +
                UInt64(uuid.1)        * 0x10000 +
                UInt64(uuid.0)        * 0x1000000 +
                UInt64(uuid.5)        * 0x100000000 +
                UInt64(uuid.4)        * 0x10000000000 +
                UInt64(uuid.7)        * 0x1000000000000 +
                UInt64(uuid.6 & 0x0F) * 0x100000000000000
        )
        
        return Date(timeInterval: TimeInterval(dateInt)/10000000, since: Date(timeIntervalSince1970: TimeInterval(-12219292800.0)))
    }
    
}
