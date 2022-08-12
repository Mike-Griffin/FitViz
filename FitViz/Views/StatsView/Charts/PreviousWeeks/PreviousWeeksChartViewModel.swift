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
        @Published var months: [String] = []
        var sortMap = ["Jan": 0,
                       "Feb": 1,
                       "Mar": 2,
                       "Apr": 3,
                       "May": 4,
                       "Jun": 5,
                       "Jul": 6,
                       "Aug": 7,
                       "Sep": 8,
                       "Oct": 9,
                       "Nov": 10,
                       "Dec": 11]
        init(activities: [FVActivity]) {
            self.activities = activities
            activityMap = activities.getActivitiesInPreviousWeeks(numWeeks: 12).groupByWeek()
            for i in 0...11 {
                print("Week number \(i)")
                print("\(activityMap[i]?.count ?? 0) activities")
                print("\(activityMap[i]?.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue) ?? 0) miles" )
            }
            // TODO: Seems a little overly intensive, I think I could do this with better performance
            let tempMonths = Array(Set(activities.map({
                $0.timestamp.epochTimeStampToDate().toMonth()
            })))
            months = tempMonths.sorted(by: {
                sortMap[$0]! < sortMap[$1]!
            })
            print(months)
        }
    }
}
