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
        init(activities: [FVActivity]) {
            self.activities = activities
            activityMap = activities.getActivitiesInPreviousWeeks(numWeeks: 12).groupByWeek()
            for i in 0...11 {
                print("Week number \(i)")
                print("\(activityMap[i]?.count ?? 0) activities")
                print("\(activityMap[i]?.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue) ?? 0) miles" )
            }
            
            // start from today's date, iterate backwards,
            // when I detect a different month then set that index
            var previousDate = Date().getFirstDayOfWeek()
            for i in 1 ..< 12 {
                let currentDate = previousDate.addingTimeInterval(TimeInterval((-1).weeksToSeconds()))
                
                if (previousDate.toMonth() != currentDate.toMonth()) {
                    dateTransitionMap[11 - i] = previousDate.toMonth()
                }
                previousDate = currentDate
            }
            
            for (_, value) in activityMap {
                maxValue = max(maxValue, Int(value.sumDistances()))
            }
            print(maxValue)
        }
    }
}
