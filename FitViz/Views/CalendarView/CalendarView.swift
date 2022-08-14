//
//  CalendarView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
    @ObservedObject var viewModel: CalendarViewModel
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        view.availableDateRange = viewModel.interval
        view.delegate = context.coordinator
        view.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reloadDecorations(forDateComponents: viewModel.activities.getDateComponents(), animated: true)
    }
    
    func makeCoordinator() -> CalendarCoordinator {
        CalendarCoordinator(self, viewModel: viewModel)
    }
    
}

class CalendarCoordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    var parent: CalendarView
    @ObservedObject var viewModel: CalendarViewModel
    
    
    init(_ parent: CalendarView, viewModel: CalendarViewModel) {
        self.parent = parent
        self.viewModel = viewModel
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if viewModel.currentDisplayedMonth != calendarView.visibleDateComponents.month {
            viewModel.currentDisplayedMonth = calendarView.visibleDateComponents.month ?? 0
            viewModel.monthUpdated()
        }
        return .customView { [self] in
            let emoji = UILabel()
            let activities = viewModel.activities.filter(dateComponents: dateComponents)
            if !activities.isEmpty {
                // TODO: Replace this to be more specific to the activity
                if activities.count > 1 {
                    emoji.text = "🚀"
                } else {
                    let activity = activities.first!
                    switch(activity.type) {
                    case ActivityType.Run.rawValue:
                        emoji.text = "🏃‍♂️"
                    case ActivityType.Ride.rawValue:
                        emoji.text = "🚲"
                    case ActivityType.Swim.rawValue:
                        emoji.text = "🏊‍♂️"
                    default:
                        emoji.text = "😖"
                    }
                }
            }
            return emoji
        }
    }
    
//    func updateActivities(_ activities: Binding<[FVActivity]>) {
//        self._activities = activities
//    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
//        let selectedActivities = viewModel.activities.map({ $0.dateComponent.date == dateComponents?.date })
        let selectedActivities = viewModel.activities.filter(dateComponents: dateComponents)
        print(selectedActivities.count)
        for activity in selectedActivities {
            print (activity.type)
        }
        
        if !selectedActivities.isEmpty {
            viewModel.selectedActivities = selectedActivities
            viewModel.showSheet = true
        }
        
    }
}
