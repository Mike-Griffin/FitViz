//
//  Array+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import Foundation

extension Array where Element == FVActivity {
    func groupByWeek() -> [Int: [FVActivity]] {
        return self.reduce(into: [Int: [FVActivity]]()) {
            $0[$1.weekNumber(), default: []].append($1)
        }
        
    }
}
