//
//  String+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

extension String {
    func activityPreviewDateDisplay() -> String {
        print(self)
        let expectedFormat = Date.ISO8601FormatStyle()
        do {
            let date = try Date(self, strategy: expectedFormat)
            return date.previewDateFormat()
        } catch {
            return self
        }
    }
}

extension Date {
    func previewDateFormat() -> String {
        print(self)
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
}
