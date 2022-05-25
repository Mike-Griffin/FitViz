//
//  MockData.swift
//  FitViz
//
//  Created by Mike Griffin on 5/24/22.
//

import CloudKit

struct MockData {
    static var activity: CKRecord {
        let record = CKRecord(recordType: RecordType.activity)
        record[FVActivity.kType] = "Run"
        record[FVActivity.kSource] = "Strava"
        record[FVActivity.kStartTime] = "Fake time"
        record[FVActivity.kDuration] = 1000
        record[FVActivity.kAveragePace] = 100.0
        record[FVActivity.kAverageHeartRate] = 99.9
        record[FVActivity.kDistance] = 99
        return record
    }
}


