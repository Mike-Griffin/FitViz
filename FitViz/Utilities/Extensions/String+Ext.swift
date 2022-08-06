//
//  String+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

extension String {
    func activityPreviewDateDisplay() -> String {
        let expectedFormat = Date.ISO8601FormatStyle()
        do {
            let date = try Date(self, strategy: expectedFormat)
            return date.previewDateFormat()
        } catch {
            return self
        }
    }
    
    func convertDateStringToEpochTimestamp() -> Int {
        let expectedFormat = Date.ISO8601FormatStyle()
        do {
            let date = try Date(self, strategy: expectedFormat)
            return date.toEpochTimeStamp()
        } catch {
            return 0
        }
    }
}

extension Date {
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
}
