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
        @Published var selectedActivityType = "All"
        @Published var startDate = Date()
        @Published var endDate = Date()
        @Published var availableTypes: [String] = ["All"]
        var selectedType: ActivityType?
        let ckManager = CloudKitManager()
        var initialLaunch = true
        var mostCommonDay: String {
            get {
                //TODO: Implement calculation for the most common day given the set of activities
                return activities.first?.startTime ?? "Thursday"
            }
        }
        
        func viewAppears() {
            if initialLaunch {
                loadActivities()
                initialLaunch = false
            }
            //TODO: Remove this debugging code
//            for dict in activities.groupByWeek() {
//                print("Key: \(dict.key)")
//                print("Count: \(dict.value.count)")
//                for activity in dict.value {
//                    print(activity.startTime)
//                }
//            }
//            let groupedActivities = activities.groupByWeek()
//
//            for index in 0...11 {
//                print("Week \(index)")
//                print(groupedActivities[index]?.count ?? 0)
//            }
            let groupedActivities = activities.getActivitiesInPreviousWeeks(numWeeks: 12).groupByWeek()
            for index in 0...11 {
                print("Week \(index)")
                print(groupedActivities[index]?.count ?? 0)
            }
            

        }
        
        func loadActivities() {
            // TODO: Load the activities in the past week
            Task {
                do {
                    activities = try await ckManager.fetchActivities()
                    if !activities.isEmpty {
                        availableTypes = ["All"]
                        let types = Set(activities.compactMap { $0.type })
                        availableTypes.append(contentsOf: types)
                        print(availableTypes)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        func userSelectedDate(to value: Date) {
            loadActivitiesWithParms()
        }
        
        func userSelectedType(to value: String) {
            print("User has selected \(value)")
            switch(value) {
            case "All":
                selectedType = nil
            case ActivityType.Run.rawValue:
                selectedType = .Run
            case ActivityType.Ride.rawValue:
                selectedType = .Ride
            case ActivityType.Swim.rawValue:
                selectedType = .Swim
            default:
                print("User selected an unexpected type")
            }
            loadActivitiesWithParms()
            
            //TODO: Remove this debug code
            print("Sum duration: ")
            print(activities.sumDurations())
            for activity in activities {
                print("Duration: ")
                print(activity.duration)
            }
            print("Sum distances: \(activities.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue))")
            
        }
        
        func loadActivitiesWithParms() {
            Task {
                do {
                    //TODO: Reconsider if I want the fetch activities function to be smart enough to ignore the start and end date if it is today
                    var startDateNotToday: Date? = startDate
                    var endDateNotToday: Date? = endDate
                    if (startDate.numericDate() == Date().numericDate()) {
                        startDateNotToday = nil
                    }
                    if (endDate.numericDate() == Date().numericDate()) {
                        endDateNotToday = nil
                    }
                    activities = try await ckManager.fetchActivities(type: selectedType, startDate: startDateNotToday, endDate: endDateNotToday)
                } catch {
                    print(error)
                }
            }
        }
        
    }
}
