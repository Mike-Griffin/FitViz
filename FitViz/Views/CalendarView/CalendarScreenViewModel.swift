//
//  CalendarScreenViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import Foundation

extension CalendarScreenView {
    @MainActor class ViewModel: ObservableObject {
        @Published var activities: [FVActivity] = []
        @Published var interval: DateInterval
        @Published var selectedActivity: FVActivity?
        @Published var showSheet: Bool = false
        var startDate: Date
        var endDate: Date
        let ckManager = CloudKitManager()
        
        init() {
            startDate = Date().getFirstDayOfWeek()
            endDate = Date()
            interval = DateInterval(start: startDate, end: endDate)
        }
        
        func fetchActivities() {
            Task {
                do {
                    activities = try await ckManager.fetchActivities(startDate: startDate, endDate: endDate)
                } catch {
                    print(error)
                }
            }
        }
        
        func fetchActivitiesWithMonth(_ month: Int) {
            print("fetching for month \(month)")
            // TODO: Remove this hard coded debugging stuff
            Task {
                do {
                    // TODO: Get the start and end dates from the month number
                    var startDateComponents = DateComponents(
                        calendar: Calendar(identifier: .gregorian),
                        timeZone: TimeZone.current,
                        year: 2022,
                        month: month,
                        day: 1
                    )
                    var startDate = startDateComponents.date!
                    var endDate = startDate.endOfMonth()
                    activities = try await ckManager.fetchActivities(startDate: startDate, endDate: endDate)
                } catch {
                    print(error)
                }
                
            }
        }
    }
}
