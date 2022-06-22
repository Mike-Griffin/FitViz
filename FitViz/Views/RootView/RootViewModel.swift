//
//  RootViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import SwiftUI

extension RootView {
    class ViewModel: ObservableObject {
        var defaultSource: [Source] = []
        let activityRequestManager = ActivityRequestManager()
        let authorizationManager = AuthorizationManager()
        let cloudkitManager = CloudKitManager()
        init() {
            authorizationManager.initAuthorization(source: .Strava) { [self] error in
                if let error = error {
                    print(error)
                } else {
                    activityRequestManager.getActivities(source: .Strava) { (result: Result<[StravaActivity], Error>) in
                        switch(result) {
                        case .success(let activities):
                            print("Great Success")
                            print(activities)
                            if let newestActivity = activities.first {
                                print(newestActivity.start_date.convertDateStringToEpochTimestamp())
                                // TODO: Convert move this logic to somewhere else within the fetching logic
                                 UserDefaultsManager.shared.setLastRetrievedTime(time: newestActivity.start_date.convertDateStringToEpochTimestamp(), source: .Strava)
                                let activityRecords = activities.map({ $0.mapToCKRecord() })
                                cloudkitManager.batchSave(records: activityRecords) { result in
                                    switch result {
                                    case .success(let records):
                                        print(records)
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
//                                UserDefaultsManager.shared.setLastRetrievedTime(time: newestActivity, source: .Strava)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
}
