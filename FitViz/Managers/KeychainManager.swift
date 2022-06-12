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
    
    func setStravaAccessCode(_ code: String) {
        keychain[KeychainKeys.stravaAccessCode.rawValue] = code
    }

}
