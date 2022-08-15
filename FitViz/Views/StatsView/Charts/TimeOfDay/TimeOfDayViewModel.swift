//
//  TimeOfDayViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import Foundation

extension TimeOfDayView {
    class ViewModel: ObservableObject {
        @Published var timeOfDayMap: [TimeOfDay: Int]
        init(activities: [FVActivity]) {
            timeOfDayMap = activities.reduce(into: [TimeOfDay: Int]()) {
                $0[$1.timeOfDay, default: 0] += 1
            }
        }
    }
}
