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
    @Published var monthDescription: String = ""
    var startDate: Date
    var endDate: Date
    let ckManager = CloudKitManager()
    
    init() {
        startDate = .now.addingTimeInterval(-24 * 30 * 24 * 3600)
        endDate = Date()
        interval = DateInterval(start: startDate, end: endDate)
    }
    

    
    func monthUpdated() {
        let startDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            timeZone: TimeZone.current,
            year: 2022,
            month: currentDisplayedMonth,
            day: 1
        )
        startDate = startDateComponents.date!
        monthDescription = startDate.formatted(.dateTime.month(.wide))
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
