//
//  Array+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import Foundation

//MARK: FVActivity
extension Array where Element == FVActivity {
    // Note: This may be getting a little carried away, I like the simplicity but I should
    // see if any of these are not used often enough to warrant being in this file
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
    
    func groupByType() -> [ActivityType: [FVActivity]] {
        return self.reduce(into: [ActivityType: [FVActivity]]()) {
            if let type = ActivityType(rawValue: $1.type) {
                $0[type, default: []].append($1)
            }
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
    
    func getMostCommonWeekday() -> (Weekday, Int) {
        var map: [Weekday: Int] = [:]
        var mostCommonDay: Weekday = .Friday
        for activity in self {
            let count = (map[activity.weekday] ?? 0) + 1
            map[activity.weekday] = count
            if count > (map[mostCommonDay] ?? 0) {
                mostCommonDay = activity.weekday
            }
        }
        return (mostCommonDay, map[mostCommonDay] ?? 0)
    }
    
    func getDateComponents() -> [DateComponents] {
        let dateComponents = self.map { $0.dateComponent }
        let set = Set(dateComponents)
        let retArray: [DateComponents] = set.compactMap {
            $0
        }
        return retArray

    }
    
    func sameDateComponent(dateComponents: DateComponents?) -> [FVActivity] {
        self.filter {
            $0.dateComponent.date == dateComponents?.date
        }
    }
    
    func afterStartDate(_ date: Date) -> [FVActivity] {
        return self.filter {
            $0.timestamp > date.toEpochTimeStamp()
        }
    }
    
    func longestStreak() -> Int {
        var maxStreak = 0
        var currentStreak = 0
        guard !self.isEmpty else { return 0 }
        let sorted = self.sorted {
            $0.timestamp < $1.timestamp
        }
        var previous = sorted[0]
        for i in 1 ..< self.count {
            let current = sorted[i]
            print("Previous time: \(previous.startTime)")
            print("Current time: \(current.startTime)")
            if current.startOfDay == previous.startOfDay.nextDay() {
                currentStreak += 1
                maxStreak = Swift.max(maxStreak, currentStreak)
            } else {
                currentStreak = 0
            }
            previous = current
        }
        return maxStreak
    }
}
