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
        record[FVActivity.kStartTime] = "2021-08-16T13:48:53Z"
        record[FVActivity.kDuration] = 1000
        record[FVActivity.kAveragePace] = 2.6640000343322754
        record[FVActivity.kAverageHeartRate] = 99.9
        record[FVActivity.kDistance] = 5000
        return record
    }
    
    static var activity2: CKRecord {
        let record = CKRecord(recordType: RecordType.activity)
        record[FVActivity.kType] = "Run"
        record[FVActivity.kSource] = "Strava"
        record[FVActivity.kStartTime] = "2021-08-17T13:48:53Z"
        record[FVActivity.kDuration] = 1000
        record[FVActivity.kAveragePace] = 100.0
        record[FVActivity.kAverageHeartRate] = 99.9
        record[FVActivity.kDistance] = 99
        return record
    }
}


