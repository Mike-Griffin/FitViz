//
//  Source.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import Foundation

enum Source {
    case Strava
    case MapMyRun
    
    func getAuthDetails() -> AuthDetails {
        switch self {
        case .Strava:
            return AuthDetailsSoure.strava
        case .MapMyRun:
            return AuthDetailsSoure.mapMyRun
        }
    }
}
