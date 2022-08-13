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
    static let activity          = "FVActivity"
    static let sourceInformation = "FVSourceInformation"
}

enum DistanceUnit: String, CaseIterable, Identifiable {
    case miles, kilometer
    var id: Self { self }
}

enum ActivityType: String, CaseIterable {
    case Run, Ride, Swim
}

enum KeychainKeys: String {
    case stravaAccessCode
    case stravaRefreshToken
}

enum DefaultsKeys: String {
    case stravaLastRetrived
}

enum Scheme {
    static let clientScheme = "FitViz"
}

enum TimeOfDay: String {
    case AM, PM
}

enum Weekday: String {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}
