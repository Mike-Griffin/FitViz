//
//  CalendarScreenView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarScreenView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Calendar!!!")
            CalendarView(
                interval: .init(
                        start: .now.addingTimeInterval(-24 * 30 * 24 * 3600),
                        end: .now
                    ),
                    activities: $viewModel.activities,
                selectedActivity: $viewModel.selectedActivity,
                showSheet: $viewModel.showSheet,
                fetchActivities: viewModel.fetchActivitiesWithMonth(_:)
            )
        }
        .sheet(isPresented: $viewModel.showSheet) {
            ActivityView(viewModel: ActivityView.ViewModel(activity: viewModel.selectedActivity!))
        }
        .onAppear{
            viewModel.fetchActivities()
        }
    }
}

struct CalendarScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreenView()
    }
}
