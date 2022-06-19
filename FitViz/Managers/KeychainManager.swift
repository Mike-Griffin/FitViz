//
//  KeychainManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import Foundation
import KeychainAccess

final class KeychainManager {
    static let shared = KeychainManager()
    let keychain = Keychain(service: "com.comedichoney.FitViz")
    
    func getStravaAccessCode() -> String? {
        keychain[KeychainKeys.stravaAccessCode.rawValue]
    }
    
    func getStravaRefreshToken() -> String? {
        keychain[KeychainKeys.stravaRefreshToken.rawValue]
    }
    
    func setStravaAccessCode(_ code: String) {
        keychain[KeychainKeys.stravaAccessCode.rawValue] = code
    }
    
    func setStravaRefreshToken(_ code: String) {
        keychain[KeychainKeys.stravaRefreshToken.rawValue] = code
    }
    
    func getRefreshTokenForSource(source: Source) -> String? {
        switch source {
        case .Strava:
            return getStravaRefreshToken()
        case .MapMyRun:
            return ""
        }
    }

}
