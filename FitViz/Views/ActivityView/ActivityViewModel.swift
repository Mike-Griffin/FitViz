//
//  ActivityViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 7/14/22.
//

import SwiftUI

extension ActivityView {
    class ViewModel: ObservableObject {
        var activity: FVActivity
        @AppStorage("distanceUnit") var distanceUnit = ""
        @Published var sameDistanceActivities: [FVActivity] = []
        let cloudkitManager = CloudKitManager()
        var activityDisplayString: String {
            get {
                return activity.distance.convertMetersToDistanceUnit(distanceUnit).formatDistanceDisplayValue()
            }
        }
        
        init(activity: FVActivity) {
            self.activity = activity
        }
        
        func fetchSameDistanceActivities() {
            cloudkitManager.fetchSameDistanceActivities(activity: activity) { [self] result in
                switch result {
                case .success(let activities):
                    print("Activities of distance \(activity.distanceRange.description)")
                    print(activities)
                    sameDistanceActivities = activities
                case .failure(let error):
                    print(error)
                }
            }
        }

    }
}
