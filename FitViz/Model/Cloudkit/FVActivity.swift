//
//  FVActivity.swift
//  FitViz
//
//  Created by Mike Griffin on 5/7/22.
//

import Foundation
import CloudKit

struct FVActivity: Identifiable {
    static let kType             = "type"
    static let kSource           = "source"
    static let kStartTime        = "startTime"
    static let kDuration         = "duration"
    static let kAveragePace      = "averagePace"
    static let kAverageHeartRate = "averageHeartRate"
    static let kDistance         = "distance"
    
    let id: CKRecord.ID
    let type: String
    let source: String
    let startTime: String
    let duration: Int
    let averagePace: Double
    let averageHeartRate: Double
    let distance: Double
    
    init(record: CKRecord) {
        id = record.recordID
        type = record[FVActivity.kType] as? String ?? "N/A"
        source = record[FVActivity.kSource] as? String ?? "N/A"
        startTime = record[FVActivity.kStartTime] as? String ?? "N/A"
        duration = record[FVActivity.kDuration] as? Int ?? 0
        averagePace = record[FVActivity.kAveragePace] as? Double ?? 0.0
        averageHeartRate = record[FVActivity.kAverageHeartRate] as? Double ?? 0.0
        distance = record[FVActivity.kDistance] as? Double ?? 0.0
    }
}