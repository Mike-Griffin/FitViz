//
//  Double+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 6/5/22.
//

import Foundation

extension Double {
    func convertMetersToDistanceUnit(_ unitString: String) -> Double {
        if let unit = DistanceUnit(rawValue: unitString) {
            switch (unit) {
            case .miles:
                return self / 1609.344
            case .kilometer:
                return self / 1000
            }
        } else {
            return self
        }
    }
    
    func formatDistanceDisplayValue() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
