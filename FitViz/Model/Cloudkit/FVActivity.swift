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
    static let kTimestamp        = "timestamp"
    
    let id: CKRecord.ID
    let type: String
    let source: String
    let startTime: String
    let duration: Int
    let averagePace: Double
    let averageHeartRate: Double
    let distance: Double
    let timestamp: Int
    
    init(record: CKRecord) {
        id = record.recordID
        type = record[FVActivity.kType] as? String ?? "N/A"
        source = record[FVActivity.kSource] as? String ?? "N/A"
        startTime = record[FVActivity.kStartTime] as? String ?? "N/A"
        duration = record[FVActivity.kDuration] as? Int ?? 0
        averagePace = record[FVActivity.kAveragePace] as? Double ?? 0.0
        averageHeartRate = record[FVActivity.kAverageHeartRate] as? Double ?? 0.0
        distance = record[FVActivity.kDistance] as? Double ?? 0.0
        timestamp = record[FVActivity.kTimestamp] as? Int ?? 0
    }
    
    var distanceRange: DistanceRange {
        get {
            if (Int(distance) < DistanceRange.UnderOneMile.upperBound) {
                // 1 mile
                return .UnderOneMile
            } else if (Int(distance) < DistanceRange.OneMile.upperBound) {
                return .OneMile
            } else if (Int(distance) < DistanceRange.TwoMile.upperBound) {
                return .TwoMile
            } else if (Int(distance) < DistanceRange.ThreeMile.upperBound) {
                return .ThreeMile
            } else if (Int(distance) < DistanceRange.FiveK.upperBound) {
                return .FiveK
            } else if (Int(distance) < DistanceRange.SixMile.upperBound) {
                return .SixMile
            } else if (Int(distance) < DistanceRange.TenK.upperBound) {
                return .TenK
            } else if (Int(distance) < DistanceRange.SevenMile.upperBound) {
                return .SevenMile
            } else if (Int(distance) < DistanceRange.EightMile.upperBound) {
                return .EightMile
            } else if (Int(distance) < DistanceRange.NineMile.upperBound) {
                return .NineMile
            } else if (Int(distance) < DistanceRange.FifteenK.upperBound) {
                return .FifteenK
            } else if (Int(distance) < DistanceRange.TenMile.upperBound) {
                return .TenMile
            } else if (Int(distance) < DistanceRange.ElevenMile.upperBound) {
                return .ElevenMile
            } else if (Int(distance) < DistanceRange.TwelveMile.upperBound) {
                return .TwelveMile
            } else if (Int(distance) < DistanceRange.ThirteenMile.upperBound) {
                return .ThirteenMile
            } else {
                return .HalfMarathon
            }
        }
    }
}


