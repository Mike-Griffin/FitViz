//
//  DeveloperViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import SwiftUI
import MapKit

extension DeveloperView {
    @MainActor class ViewModel: ObservableObject {
        var cloudkitManager = CloudKitManager()
        @Published var stravaAccessCode = ""
        @Published var stravaRefreshToken = ""
        @Published var stravaLastFetchTime = ""
        @Published var stravaExpirationTime = ""
        @Published var centerLatitude = ""
        @Published var centerLongitude = ""
        @Published var latitudeDelta = ""
        @Published var longitudeDelta = ""
        @Published var region: MKCoordinateRegion?
        @Published var showingMap = false

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
        
        func deleteAllActivities() {
            Task {
                do {
                    try await cloudkitManager.deleteAllActivities()
                    try await cloudkitManager.deleteSourceInformationRecord(source: .Strava)
                } catch {
                    print("error on delete")
                }
            }
        }
        
        func setRegion() {
            if let centerLatitudeDegrees = Double(centerLatitude),
               let centerLongitudeDegrees = Double(centerLongitude),
               let spanLatitude = Double(latitudeDelta),
            let spanLongitude = Double(longitudeDelta) {
                   print("set latitude time")
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLatitudeDegrees, longitude: centerLongitudeDegrees), span: MKCoordinateSpan(latitudeDelta: spanLatitude, longitudeDelta: spanLongitude))
                showingMap = true
               }
            
        }
    }
}
