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
}
