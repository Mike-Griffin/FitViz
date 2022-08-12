//
//  Int+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import Foundation

extension Int {
    func epochTimeStampToDate() -> Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    
    func daysToSeconds() -> Int {
        return self * 86400
    }
    
    func weeksToSeconds() -> Int {
        return self * 604800
    }
}
