//
//  CalendarScreenViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import Foundation

@MainActor class CalendarViewModel: ObservableObject {
    @Published var activities: [FVActivity] = []
    @Published var interval: DateInterval
    @Published var selectedActivities: [FVActivity] = []
    @Published var showSheet: Bool = false
    @Published var currentDisplayedMonth = 0
    @Published var currentDisplayedYear = 2022
    @Published var monthDescription: String = ""
    @Published var intervalChecked = false
    var startDate: Date
    var endDate: Date
    let ckManager = CloudKitManager()
    
    init() {
        startDate = .now.addingTimeInterval(-24 * 30 * 24 * 3600)
        endDate = Date()
        interval = DateInterval(start: startDate, end: endDate)
        Task {
            do {
                let sourceInfo = try await ckManager.getSourceInformation(source: .Strava)
                if let firstDate = sourceInfo?.firstFetched.epochTimeStampToDate() {
                    startDate = firstDate
                    interval = DateInterval(start: startDate, end: endDate)
                    intervalChecked = true
                } else {
                    print("Error: didn't find the first fetch time in the calendar")
                    intervalChecked = true
                }
            } catch {
                print(error)
                intervalChecked = true
            }
        }

    }
    

    
    func monthUpdated() {
        let startDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            timeZone: TimeZone.current,
            year: currentDisplayedYear,
            month: currentDisplayedMonth,
            day: 1
        )
        startDate = startDateComponents.date!
        monthDescription = startDate.formatted(.dateTime.month(.wide)) + " " + startDate.formatted(.dateTime.year())
        endDate = startDate.endOfMonth()
        
        fetchActivities()
    }
    
    func fetchActivities() {
        print("fetching for month \(currentDisplayedMonth)")
        Task {
            do {
                activities = try await ckManager.fetchActivities(startDate: startDate, endDate: endDate)
            } catch {
                print(error)
            }
            
        }
    }
    

}
