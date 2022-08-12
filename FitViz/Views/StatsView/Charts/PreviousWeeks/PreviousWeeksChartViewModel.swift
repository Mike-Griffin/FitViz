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
        init(activities: [FVActivity]) {
            self.activities = activities
        }
    }
}
