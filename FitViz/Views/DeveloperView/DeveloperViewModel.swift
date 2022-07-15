//
//  DeveloperViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import SwiftUI

extension DeveloperView {
    class ViewModel: ObservableObject {
        var cloudkitManager = CloudKitManager()
        @Published var stravaAccessCode = ""
        @Published var stravaRefreshToken = ""
        @Published var stravaLastFetchTime = ""
        @Published var stravaExpirationTime = ""

        func fetchValues() {
            if let stravaCode = KeychainManager.shared.getStravaAccessCode() {
                print("Keychain code: \(stravaCode)")
                stravaAccessCode = stravaCode
            }
            
            if let stravaRefreshToken = KeychainManager.shared.getStravaRefreshToken() {
                self.stravaRefreshToken = stravaRefreshToken
            }
            
            stravaLastFetchTime = "\(UserDefaultsManager.shared.getLastRetrievedTime(source: .Strava))"
        }
        
        func setStravaAccessCodeToKeychain() {
            KeychainManager.shared.setStravaAccessCode(stravaAccessCode)
        }
        
        func setStravaRefreshTokenToKeychain() {
            KeychainManager.shared.setStravaRefreshToken(stravaRefreshToken)
        }
        
        func setStravaLastFetchTime() {
            if let intCast = Int(stravaLastFetchTime) {
                UserDefaultsManager.shared.setLastRetrievedTime(time: intCast, source: .Strava)
            } else {
                print("attempt to set strava last fetch time without an int")
            }
        }
    }
}
