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
        @Published var longestActivity: FVActivity?
        var selectedType: ActivityType?
        let ckManager = CloudKitManager()
        var initialLaunch = true
        
        //MARK: Previous Calendar View properties
        @Published var activityMap: [Int: [FVActivity]] = [:]
        @Published var dateTransitionMap: [Int: String] = [:]
        @Published var maxValue: Int = 0
        @Published var animateMap: [Int: Bool] = [:]
        
        func viewAppears() {
            if initialLaunch {
                loadActivities()
                initialLaunch = false
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
                        updatePreviousWeekValues()
                        longestActivity = activities.sorted(by: {
                            $0.distance > $1.distance
                        }).first
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
                    updatePreviousWeekValues()

                } catch {
                    print(error)
                }
            }
        }
        
        func updatePreviousWeekValues() {
            activityMap = activities.getActivitiesInPreviousWeeks(numWeeks: 12).groupByWeek()
            // start from today's date, iterate backwards,
            // when I detect a different month then set that index
            var previousDate = Date().getFirstDayOfWeek()
//            animateMap = [:]
            for i in 1 ..< 12 {
                let currentDate = previousDate.addingTimeInterval(TimeInterval((-1).weeksToSeconds()))

                if (previousDate.toMonth() != currentDate.toMonth()) {
                    dateTransitionMap[11 - i] = previousDate.toMonth()
                }
                previousDate = currentDate
            }

            for (_, value) in activityMap {
                maxValue = max(maxValue, Int(value.sumDistances()))
            }
        }
        
    }
}
