//
//  MostCommonTimeOfDayViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import Foundation

extension MostCommonDayView {
    class ViewModel: ObservableObject {
        @Published var mostCommonDay: Weekday
        @Published var activityCount: Int
        init(activities: [FVActivity]) {
            let (day, count) = activities.getMostCommonWeekday()
            mostCommonDay = day
            activityCount = count
        }
    }
}
