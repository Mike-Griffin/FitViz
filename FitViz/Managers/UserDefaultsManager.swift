//
//  UserDefaultsManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/19/22.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    
    func getLastRetrievedTime(source: Source) -> Int {
        switch source {
        case .Strava:
            return defaults.integer(forKey: DefaultsKeys.stravaLastRetrived.rawValue)
        case .MapMyRun:
            return 0
        }
    }
    
    func setLastRetrievedTime(time: Int, source: Source) {
        switch source {
        case .Strava:
            defaults.set(time, forKey: DefaultsKeys.stravaLastRetrived.rawValue)
        case .MapMyRun:
            print("map my run not done")
        }
    }
}
