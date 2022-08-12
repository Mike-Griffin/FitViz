//
//  RootViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import SwiftUI
import CloudKit

extension RootView {
    @MainActor class ViewModel: ObservableObject {
        var defaultSource: [Source] = []
        let activityRequestManager = ActivityRequestManager()
        let authorizationManager = AuthorizationManager()
        let cloudkitManager = CloudKitManager()
        // TODO: Change this to show a loading spinner while it's loading
        @Published var loading = true
        @Published var alertItem: AlertItem?
        
        init() {
            Task {
                do {
                    try await cloudkitManager.checkUser()
                    fetchStrava()
                } catch {
                    print("Error in the RootView model")
                    print(error)
                    alertItem = AlertContext.noUserRecord
                }
            }
        }
        
        func fetchStrava() {
            authorizationManager.initAuthorization(source: .Strava) { [self] error in
                if let error = error {
                    print(error)
                    loading = false
                } else {
                    Task {
                        do {
                            let activities = try await activityRequestManager.getActivities(source: .Strava)
                            if let newestActivity = activities.sorted(by: {
                                $0.timestamp < $1.timestamp
                            }).last {
                                print(newestActivity.start_date.convertDateStringToEpochTimestamp())
                                // TODO: Convert move this logic to somewhere else within the fetching logic
                                // UserDefaultsManager.shared.setLastRetrievedTime(time: newestActivity.start_date.convertDateStringToEpochTimestamp(), source: .Strava)
                                saveLastFetched(time: newestActivity.timestamp, source: .Strava)
                                let activityRecords = activities.map({ $0.mapToCKRecord() })
                                let savedRecords = try await cloudkitManager.batchSave(records: activityRecords)
                                print(savedRecords)
                                loading = false
                            } else {
                                loading = false
                            }
                            
                        } catch {
                            print(error)
                            loading = false
                        }
                    }
                }
            }
            
        }
        
        func saveLastFetched(time: Int, source: Source) {
            Task {
                do {
                    if let infoRecord = try await cloudkitManager.getSourceInformationRecord(source: source) {
                        infoRecord[FVSourceInformation.kLastFetched] = time
                        let _ = try await cloudkitManager.save(record: infoRecord)
                    } else {
                        let record = CKRecord(recordType: RecordType.sourceInformation)
                        record[FVSourceInformation.kSource] = source.rawValue
                        record[FVSourceInformation.kLastFetched] = time
                        let _ = try await cloudkitManager.save(record: record)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
