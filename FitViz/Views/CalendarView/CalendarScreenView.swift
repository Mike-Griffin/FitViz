//
//  CalendarScreenView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarScreenView: View {
    @ObservedObject var viewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            Text("Calendar for the month of \(viewModel.monthDescription)!!!")
            Text("\(viewModel.activities.count) total sessions!")
            Text("\(viewModel.activities.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue).formatDistanceDisplayValue()) miles completed")
            CalendarView(
                viewModel: viewModel
            )
        }
        .sheet(isPresented: $viewModel.showSheet, onDismiss: {
            viewModel.selectedActivities = []
        }) {
            if viewModel.selectedActivities.count == 1 {
                ActivityView(viewModel: ActivityView.ViewModel(activity: viewModel.selectedActivities.first!))
            } else if viewModel.selectedActivities.count > 1 {
                ActivityListView(activities: viewModel.selectedActivities)
            }
        }
    }
}

struct CalendarScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreenView()
    }
}
