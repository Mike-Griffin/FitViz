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
    
    func timeOfDay() -> TimeOfDay {
        if (self.formatted(.dateTime.hour()).contains(TimeOfDay.AM.rawValue)) {
            return .AM
        } else {
            return .PM
        }
    }
    
    func getFirstDayOfWeek() -> Date {
        // get the weekday
        let weekday = -1 * ((Int(self.formatted(.dateTime.weekday(.oneDigit))) ?? 0) - 1)
        let weekdayInSeconds = weekday.daysToSeconds()
        let startDayOfWeek = self.addingTimeInterval(TimeInterval(weekdayInSeconds))
        return(Calendar.current.startOfDay(for: startDayOfWeek))
    }
    
    func getFirstDayOfWeekTimeStamp() -> Int {
        return self.getFirstDayOfWeek().toEpochTimeStamp()
    }
    
    func getDaysBefore(_ num: Int) -> Date {
        let date = self.addingTimeInterval(TimeInterval(-1 * num.daysToSeconds()))
        return(Calendar.current.startOfDay(for: date))
    }
    
    func previewDateFormat() -> String {
        let diff = Calendar.current.dateComponents([.day], from: self, to: Date())
        let timeDisplay = self.formatted(.dateTime.hour().minute(.twoDigits))
        if diff.day == 0 {
            return "Today at \(timeDisplay)"
        } else if diff.day == 1 {
            return "Yesterday at \(timeDisplay)"
        } else {
            return self.formatted()
        }
    }
    
    func toEpochTimeStamp() -> Int {
        return Int(self.timeIntervalSince1970)
    }
    
    func toTimeDisplay() -> String {
        return self.formatted(.dateTime.hour().minute(.twoDigits))
    }
    
    func toMonth() -> String {
        return self.formatted(.dateTime.month(.abbreviated))
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDay() -> Date {
        return self.addingTimeInterval(TimeInterval((1).daysToSeconds()))
    }
}
