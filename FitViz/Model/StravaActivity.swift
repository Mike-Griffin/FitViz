//
//  StravaActivity.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

struct StravaActivityResponse {
    let activities: [StravaActivity]
}

struct StravaActivity: Decodable {
    let name: String
    // TODO: Consider using start time local to account for time zone
    // TODO: Add coding keys to make this startTime
    let start_date: String
}
