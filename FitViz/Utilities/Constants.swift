//
//  Constants.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import Foundation

enum CloudKitKeys: String {
    case stravaLastFetch = "kStravaLastFetch"
}

enum RecordType {
    static let activity = "FVActivity"
}

enum DistanceUnit: String, CaseIterable, Identifiable {
    case miles, kilometer
    var id: Self { self }
}

enum ActivityType: String, CaseIterable {
    case Run, Bike
}

enum KeychainKeys: String {
    case stravaAccessCode
}

enum Scheme {
    static let clientScheme = "FitViz"
}
