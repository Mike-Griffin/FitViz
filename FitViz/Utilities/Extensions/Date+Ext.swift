//
//  Date+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 8/6/22.
//

import Foundation

extension Date {
    func numericDate() -> String {
        return self.formatted(date: .numeric, time: .omitted)
    }
    
    func weekNumber() -> Int {
        return Int(self.formatted(.dateTime.week())) ?? -1
    }
}
