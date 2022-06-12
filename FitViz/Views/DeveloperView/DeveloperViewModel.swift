//
//  DeveloperViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import SwiftUI
import KeychainAccess

extension DeveloperView {
    class ViewModel: ObservableObject {
        @Published var stravaAccessCode = ""
        let keychain = Keychain(service: "com.comedichoney.FitViz")

        init() {
            if let stravaCode = keychain[KeychainKeys.stravaAccessCode.rawValue] {
                print("Keychain code: \(stravaCode)")
                stravaAccessCode = stravaCode
            }
        }
        
        func setStravaAccessCodeToKeychain() {
            keychain[KeychainKeys.stravaAccessCode.rawValue] = stravaAccessCode
        }
    }
}
