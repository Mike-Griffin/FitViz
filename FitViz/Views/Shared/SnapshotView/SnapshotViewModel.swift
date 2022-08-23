//
//  SnapshotViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/20/22.
//

import Foundation

    class SnapshotViewModel: ObservableObject {
        @Published var activities: [FVActivity]
        @Published var header: String
        @Published var longestStreak: Int
        @Published var totalDistance: String
        @Published var averageDistance: String
        @Published var totalDuration: String
        @Published var typeMap: [ActivityType: [FVActivity]]
        init(activities: [FVActivity], header: String) {
            self.activities = activities
            self.header = header
            self.longestStreak = activities.longestStreak()
            self.totalDistance = activities.sumDistances().displayInUnit(.miles)
            if !activities.isEmpty {
                self.averageDistance = (activities.sumDistances() / Double(activities.count)).displayInUnit(.miles)
            } else {
                self.averageDistance = ""
            }
            self.totalDuration = String(activities.sumDurations().secondsToHours())
            self.typeMap = activities.groupByType()
        }
    }
