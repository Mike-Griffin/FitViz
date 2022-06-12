//
//  DeveloperViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import SwiftUI

extension DeveloperView {
    class ViewModel: ObservableObject {
        @Published var stravaAccessCode = ""

        init() {
            if let stravaCode = KeychainManager.shared.getStravaAccessCode() {
                print("Keychain code: \(stravaCode)")
                stravaAccessCode = stravaCode
            }
        }
        
        func setStravaAccessCodeToKeychain() {
            KeychainManager.shared.setStravaAccessCode(stravaAccessCode)
        }
    }
}
