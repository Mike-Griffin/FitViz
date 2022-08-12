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
            for map in activityMap {
                print("Week number \(map.key)")
                print(map.value.count)
            }
        }
    }
}
