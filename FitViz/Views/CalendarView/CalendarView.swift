//
//  CalendarView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
    @ObservedObject var viewModel: CalendarViewModel
//    let interval: DateInterval
//    @Binding var activities: [FVActivity]
//    @Binding var selectedActivity: FVActivity?
//    @Binding var showSheet: Bool
//    var fetchActivities: (Int)->()
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        view.availableDateRange = viewModel.interval
        view.delegate = context.coordinator
        view.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // TODO: create a function on the activities array to get the date component for an activity
        print("uiview is updated")
        print(uiView.visibleDateComponents)
//        context.coordinator.updateActivities(viewModel.activities)
        uiView.reloadDecorations(forDateComponents: viewModel.activities.getDateComponents(), animated: true)
    }
    
    func makeCoordinator() -> CalendarCoordinator {
        CalendarCoordinator(self, viewModel: viewModel)
    }
    
}

class CalendarCoordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    var parent: CalendarView
//    @Binding var activities: [FVActivity]
    var currentMonth: Int
//    var fetchActivities: (Int)->()
    
    @ObservedObject var viewModel: CalendarViewModel
    
    
    init(_ parent: CalendarView, viewModel: CalendarViewModel) {
        self.parent = parent
        self.viewModel = viewModel
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
            viewModel.fetchActivitiesWithMonth(currentMonth)
            
        }
        return .customView { [self] in
            let emoji = UILabel()
            if viewModel.activities.contains(where: {
                return $0.dateComponent.date == dateComponents.date
            }) {
                // TODO: Replace this to be more specific to the activity
                emoji.text = "🚀"
            }
            return emoji
        }
    }
    
//    func updateActivities(_ activities: Binding<[FVActivity]>) {
//        self._activities = activities
//    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let selectedActivity = viewModel.activities.first(where: {
            $0.dateComponent.date == dateComponents?.date
        }) {
            viewModel.selectedActivity = selectedActivity
            viewModel.showSheet = true
        }
        
    }
}
