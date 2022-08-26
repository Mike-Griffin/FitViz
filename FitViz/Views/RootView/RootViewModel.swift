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
//        @AppStorage("distanceUnit") var distanceUnit: String
        
        init() {
            print("Locale: \(Locale.current.identifier)")
            switch(Locale.current.identifier) {
            case("en_US"):
                UserDefaults.standard.set(DistanceUnit.miles.rawValue, forKey: "distanceUnit")
            case("en_CA"):
                UserDefaults.standard.set(DistanceUnit.kilometer.rawValue, forKey: "distanceUnit")
            default:
                print("Not a known locale \(Locale.current.identifier)")
//                distanceUnit = ""
            }
            Task {
                do {
                    try await cloudkitManager.checkUser()
                    fetchStrava()
                } catch {
                    print("Error in the RootView model")
                    print(error)
                    alertItem = AlertContext.noUserRecord
                    loading = false
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
                            var urlString = "https://www.strava.com/api/v3/athlete/activities"

                            let sourceInfo = try await cloudkitManager.getSourceInformation(source: .Strava)
                            print(sourceInfo ?? "NO SOURCE INFO")
                            let lastFetchTime = sourceInfo?.lastFetched ?? 0
                            if lastFetchTime == 0 {
                                print("last fetch time is not found")
                                urlString += "?per_page=100"
                                var fetchedActivities = try await activityRequestManager.getActivities(source: .Strava, urlString: urlString)
                                if let newestActivity = fetchedActivities.sorted(by: {
                                    $0.timestamp < $1.timestamp
                                }).last {
                                    saveLastFetched(time: newestActivity.timestamp, source: .Strava)
                                    let fetchedRecords = fetchedActivities.map({ $0.mapToCKRecord() })
                                    let _ = try await cloudkitManager.batchSave(records: fetchedRecords)
                                }
                                var page = 1
                                let originalString = urlString
                                while (fetchedActivities.count == 100 && page < 10) {
                                    page += 1
                                    urlString = originalString + "&page=\(page)"
                                    print(page)
                                    print(fetchedActivities.count)
                                    fetchedActivities = try await activityRequestManager.getActivities(source: .Strava, urlString: urlString)
                                    let fetchedRecords = fetchedActivities.map({ $0.mapToCKRecord() })
                                    let _ = try await cloudkitManager.batchSave(records: fetchedRecords)
                                }
                                // save the first fetched timestamp
                                if let oldestActivity = fetchedActivities.sorted(by: {
                                    $0.timestamp < $1.timestamp
                                }).first {
                                    saveFirstFetched(time: oldestActivity.timestamp, source: .Strava)
                                }
                                loading = false
                            } else {
                                print("last fetch time is not zero")
                                urlString += "?after=\(lastFetchTime)"
                                let activities = try await activityRequestManager.getActivities(source: .Strava, urlString: urlString)
                                if let newestActivity = activities.sorted(by: {
                                    $0.timestamp < $1.timestamp
                                }).last {
                                    // TODO: Convert move this logic to somewhere else within the fetching logic
                                    // UserDefaultsManager.shared.setLastRetrievedTime(time: newestActivity.start_date.convertDateStringToEpochTimestamp(), source: .Strava)
                                    saveLastFetched(time: newestActivity.timestamp, source: .Strava)
                                    let activityRecords = activities.map({ $0.mapToCKRecord() })
                                    let _ = try await cloudkitManager.batchSave(records: activityRecords)
                                    loading = false
                                } else {
                                    loading = false
                                }
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
        
        func saveFirstFetched(time: Int, source: Source) {
            Task {
                do {
                    if let infoRecord = try await cloudkitManager.getSourceInformationRecord(source: source) {
                        infoRecord[FVSourceInformation.kFirstFetched] = time
                        let _ = try await cloudkitManager.save(record: infoRecord)
                    } else {
                        print("Error: Saving the first fetched but there isn't a source found")
                        let record = CKRecord(recordType: RecordType.sourceInformation)
                        record[FVSourceInformation.kSource] = source.rawValue
                        record[FVSourceInformation.kFirstFetched] = time
                        let _ = try await cloudkitManager.save(record: record)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
