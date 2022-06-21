//
//  HealthKitManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/20/22.
//

import Foundation
import HealthKit

final class KeychainManager {
    static let shared = KeychainManager()
    let healthStore = HKHealthStore()
}
