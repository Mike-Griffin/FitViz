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
