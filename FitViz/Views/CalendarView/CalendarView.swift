//
//  CalendarView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {

    let interval: DateInterval
    @Binding var activities: [FVActivity]
    @Binding var selectedActivity: FVActivity?
    @Binding var showSheet: Bool
    var fetchActivities: (Int)->()
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        view.availableDateRange = interval
        view.delegate = context.coordinator
        view.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // TODO: create a function on the activities array to get the date component for an activity
        print("uiview is updated")
        print(uiView.visibleDateComponents)
        context.coordinator.updateActivities($activities)
        uiView.reloadDecorations(forDateComponents: activities.getDateComponents(), animated: true)
    }
    
    func makeCoordinator() -> CalendarCoordinator {
        CalendarCoordinator(self, activities: $activities, fetchActivities: fetchActivities)
    }
    
}

class CalendarCoordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    var parent: CalendarView
    @Binding var activities: [FVActivity]
    var currentMonth: Int
    var fetchActivities: (Int)->()
    
    
    init(_ parent: CalendarView, activities: Binding<[FVActivity]>, fetchActivities: @escaping (Int) -> ()) {
        self.parent = parent
        self._activities = activities
        self.fetchActivities = fetchActivities
        currentMonth = 0
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        print("Visible date components: \(calendarView.visibleDateComponents)")
//        print(dateComponents.day)
        if currentMonth != calendarView.visibleDateComponents.month {
            currentMonth = calendarView.visibleDateComponents.month ?? 0
            // should I pass down the function to fetch new activities?
            // this feels like I could run into performance issues
            print("Got a different month in here \(currentMonth)")
            fetchActivities(currentMonth)
            
        }
        return .customView { [self] in
            let emoji = UILabel()
            if activities.contains(where: {
                return $0.dateComponent.date == dateComponents.date
            }) {
                // TODO: Replace this to be more specific to the activity
                emoji.text = "🚀"
            }
            return emoji
        }
    }
    
    func updateActivities(_ activities: Binding<[FVActivity]>) {
        self._activities = activities
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let selectedActivity = activities.first(where: {
            $0.dateComponent.date == dateComponents?.date
        }) {
            parent.selectedActivity = selectedActivity
            parent.showSheet = true
        }
        
    }
}
