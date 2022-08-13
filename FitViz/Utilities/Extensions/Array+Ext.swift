//
//  Array+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import Foundation

extension Array where Element == FVActivity {
    func groupByWeek() -> [Int: [FVActivity]] {
        let currentWeekNumber = Date().weekNumber()
        // TODO: Determine how this works in the case where it crosses over the new year
        let offsetNumber = currentWeekNumber - 11
        print("Current Week Number: \(currentWeekNumber)")
        print("Offset Number: \(offsetNumber)")
        return self.reduce(into: [Int: [FVActivity]]()) {
            $0[$1.weekNumber() - offsetNumber, default: []].append($1)
        }
    }
        
    func getActivitiesInPreviousWeeks(numWeeks: Int) -> [FVActivity] {
        // This looks at the entire week, so the current week is halfway through
        let firstDayOfWeekTimestamp = Date().getFirstDayOfWeekTimeStamp()
        let modifiedNumWeeks = (numWeeks - 1)
        let startDateTimeStamp = firstDayOfWeekTimestamp - modifiedNumWeeks.weeksToSeconds()
        let date = Date(timeIntervalSince1970: TimeInterval(startDateTimeStamp))
        print("Start Date as date: \(date)")
        print("Start Date timestamp: \(startDateTimeStamp)")
        return self.filter {
            $0.timestamp >= startDateTimeStamp
        }
    }
    
    func sumDurations() -> Int {
        return self.reduce(0) { 
            $0 + $1.duration
        }
    }
    
    func sumDistances() -> Double {
        return self.reduce(0) {
            $0 + $1.distance
        }
    }
}
