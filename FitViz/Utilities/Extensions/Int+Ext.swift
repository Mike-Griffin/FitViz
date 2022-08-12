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
}
