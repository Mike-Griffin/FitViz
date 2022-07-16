//
//  DistanceRange.swift
//  FitViz
//
//  Created by Mike Griffin on 7/16/22.
//

import Foundation

// TODO: This should have a Meters equivalent
enum DistanceRange {
    case UnderOneMile
    case OneMile
    case TwoMile
    case ThreeMile
    case FiveK
    case FourMile
    case FiveMile
    case SixMile
    case TenK
    case SevenMile
    case EightMile
    case NineMile
    case FifteenK
    case TenMile
    case ElevenMile
    case TwelveMile
    case ThirteenMile
    case HalfMarathon
    
    var description: String {
        switch self {
        case .UnderOneMile:
            return "Under 1 Mile"
        case .OneMile:
            return "1 Mile"
        case .TwoMile:
            return "2 Miles"
        case .ThreeMile:
            return "5 Miles"
        case .FiveK:
            return "5K"
        case .FourMile:
            return "4 Miles"
        case .FiveMile:
            return "5 Miles"
        case .SixMile:
            return "6 Miles"
        case .TenK:
            return "10K"
        case .SevenMile:
            return "7 Miles"
        case .EightMile:
            return "8 Miles"
        case .NineMile:
            return "9 Miles"
        case .FifteenK:
            return "15K"
        case .TenMile:
            return "10 Miles"
        case .ElevenMile:
            return "11 Miles"
        case .TwelveMile:
            return "12 Miles"
        case .ThirteenMile:
            return "13 Miles"
        case .HalfMarathon:
            return "Half Marathon"
        }
    }
    
    var lowerBound: Int {
        switch(self) {
        case .UnderOneMile:
            return 0
        case .OneMile:
            return 1609
        case .TwoMile:
            return 3218
        case .ThreeMile:
            return 4828
        case .FiveK:
            return 5000
        case .FourMile:
            return 6437
        case .FiveMile:
            return 8046
        case .SixMile:
            return 9656
        case .TenK:
            return 10000
        case .SevenMile:
            return 11265
        case .EightMile:
            return 12874
        case .NineMile:
            return 14484
        case .FifteenK:
            return 15000
        case .TenMile:
            return 16093
        case .ElevenMile:
            return 17702
        case .TwelveMile:
            return 19312
        case .ThirteenMile:
            return 20921
        case .HalfMarathon:
            return 21097
        }
    }
    
    var upperBound: Int {
        switch self {
        case .UnderOneMile:
            return DistanceRange.OneMile.lowerBound
        case .OneMile:
            return DistanceRange.TwoMile.lowerBound
        case .TwoMile:
            return DistanceRange.ThreeMile.lowerBound
        case .ThreeMile:
            return DistanceRange.FiveK.lowerBound
        case .FiveK:
            return DistanceRange.FourMile.lowerBound
        case .FourMile:
            return DistanceRange.FiveMile.lowerBound
        case .FiveMile:
            return DistanceRange.SixMile.lowerBound
        case .SixMile:
            return DistanceRange.TenK.lowerBound
        case .TenK:
            return DistanceRange.SevenMile.lowerBound
        case .SevenMile:
            return DistanceRange.EightMile.lowerBound
        case .EightMile:
            return DistanceRange.NineMile.lowerBound
        case .NineMile:
            return DistanceRange.FifteenK.lowerBound
        case .FifteenK:
            return DistanceRange.TenMile.lowerBound
        case .TenMile:
            return DistanceRange.ElevenMile.lowerBound
        case .ElevenMile:
            return DistanceRange.TwelveMile.lowerBound
        case .TwelveMile:
            return DistanceRange.ThirteenMile.lowerBound
        case .ThirteenMile:
            return DistanceRange.HalfMarathon.lowerBound
        case .HalfMarathon:
            return 10000000
        }
    }
}
