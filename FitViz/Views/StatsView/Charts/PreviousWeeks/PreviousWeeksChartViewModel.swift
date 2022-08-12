//
//  PreviousWeeksChartViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import Foundation

extension PreviousWeeksChartView {
    class ViewModel: ObservableObject {
        @Published var activities: [FVActivity]
        @Published var activityMap: [Int: [FVActivity]]
        init(activities: [FVActivity]) {
            self.activities = activities
            activityMap = activities.getActivitiesInPreviousWeeks(numWeeks: 12).groupByWeek()
            for i in 0...11 {
                print("Week number \(i)")
                print("\(activityMap[i]?.count ?? 0) activities")
                print("\(activityMap[i]?.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue) ?? 0) miles" )
            }
        }
    }
}
