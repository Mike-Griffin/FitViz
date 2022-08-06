//
//  StatsViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/4/22.
//

import Foundation

extension StatsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var activities: [FVActivity] = []
        @Published var activityType: ActivityType?
        @Published var startDate = Date()
        @Published var endDate = Date()
        let ckManager = CloudKitManager()
        var mostCommonDay: String {
            get {
                //TODO: Implement calculation for the most common day given the set of activities
                return activities.first?.startTime ?? "Thursday"
            }
        }
        
        func loadActivities() {
            // TODO: Load the activities in the past week
            Task {
                do {
                    activities = try await ckManager.loadActivities()
                } catch {
                    print(error)
                }
            }
        }
        
        func userSelectedDate(to value: Date) {
            loadActivitiesWithParms()
        }
        
        func loadActivitiesWithParms() {
            if startDate.numericDate() != Date().numericDate() {
                Task {
                    do {
                        activities = try await ckManager.fetchActivities(after: startDate)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
}
