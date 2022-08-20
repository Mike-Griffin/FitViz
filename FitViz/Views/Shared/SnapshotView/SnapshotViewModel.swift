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
        init(activities: [FVActivity], header: String) {
            self.activities = activities
            self.header = header
            self.longestStreak = activities.longestStreak()
        }
    }
