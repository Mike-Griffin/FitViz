//
//  StatsViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/4/22.
//

import Foundation

extension StatsView {
    class ViewModel: ObservableObject {
        @Published var activities: [FVActivity] = []
        var mostCommonDay: String {
            get {
                //TODO: Implement calculation for the most common day given the set of activities
                return activities.first?.startTime ?? "Thursday"
            }
        }
        
        func loadActivities() {
            activities = [FVActivity(record: MockData.activity)]
        }
        
    }
}
