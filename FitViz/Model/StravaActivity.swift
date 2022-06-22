//
//  StravaActivity.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation
import CloudKit

struct StravaActivityResponse {
    let activities: [StravaActivity]
}

struct StravaActivity: Decodable {
    // TODO: Consider if name is even needed
    let name: String
    // TODO: Consider using start time local to account for time zone
    // TODO: Add coding keys to make this startTime
    let start_date: String
    let type: String
    let distance: Float
    let moving_time: Int
    let average_speed: Float
    let average_heartrate: Float
}

extension StravaActivity {
    func mapToCKRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordType.activity)
        record[FVActivity.kStartTime] = self.start_date
        record[FVActivity.kSource] = Source.Strava.rawValue
        record[FVActivity.kType] = self.type
        record[FVActivity.kDistance] = self.distance
        record[FVActivity.kDuration] = self.moving_time
        record[FVActivity.kAveragePace] = self.average_speed
        record[FVActivity.kAverageHeartRate] = self.average_heartrate
        return record
    }
}
