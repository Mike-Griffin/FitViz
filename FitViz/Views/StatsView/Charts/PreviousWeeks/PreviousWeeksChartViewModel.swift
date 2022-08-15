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
        @Published var dateTransitionMap: [Int: String] = [:]
        @Published var maxValue: Int = 0
        @Published var animateMap: [Int: Int] = [:]
        
        init(activities: [FVActivity]) {
            self.activities = activities
            activityMap = activities.getActivitiesInPreviousWeeks(numWeeks: 12).groupByWeek()
            // start from today's date, iterate backwards,
            // when I detect a different month then set that index
            var previousDate = Date().getFirstDayOfWeek()
//            animateMap = [:]
            for i in 1 ..< 12 {
                let currentDate = previousDate.addingTimeInterval(TimeInterval((-1).weeksToSeconds()))
                
                if (previousDate.toMonth() != currentDate.toMonth()) {
                    dateTransitionMap[11 - i] = previousDate.toMonth()
                }
                previousDate = currentDate
//                animateMap[i] = 0
            }
            
            for (_, value) in activityMap {
                maxValue = max(maxValue, Int(value.sumDistances()))
            }
        }
    }
}
