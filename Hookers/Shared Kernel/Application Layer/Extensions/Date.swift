//
//  Date.swift
//  Hookers
//
//  Created by Kirill Sokolov on 20.12.2018.
//  Copyright © 2018 Приват24. All rights reserved.
//

import Foundation

extension Date {
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
}

extension Date {
    
    private static var calendar = Calendar.current
    private static var dateFormatter = DateFormatter()
    
    func years(from date: Date) -> Int {
        return Date.calendar.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    func months(from date: Date) -> Int {
        return Date.calendar.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    func weeks(from date: Date) -> Int {
        return Date.calendar.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    
    func days(from date: Date) -> Int {
        return Date.calendar.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Date.calendar.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return Date.calendar.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func seconds(from date: Date) -> Int {
        return Date.calendar.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    static func isTheSameDay(date1: Date, date2: Date) -> Bool {
        return Date.calendar.compare(date1, to: date2, toGranularity: .day) == .orderedSame
    }
    
    static func isDateInToday(from date: Date) -> Bool {
        return Date.calendar.isDateInToday(date)
    }
    
    static func isDateInYesterday(from date: Date) -> Bool {
        return Date.calendar.isDateInYesterday(date)
    }
    
    func isInSameYear() -> Bool {
        return Date.calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
}
