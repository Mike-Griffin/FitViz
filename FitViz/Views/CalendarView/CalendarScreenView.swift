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
            CalendarHeaderView(viewModel: viewModel)
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

struct CalendarHeaderView: View {
    @ObservedObject var viewModel: CalendarViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.monthDescription) Summary")
                .font(.headline)
            Grid() {
                GridRow() {
                    Text("")
                    Text("Total")
                    Text("Average")
                }
                GridRow() {
                    Text("Activities")
                        .multilineTextAlignment(.leading)
                    Text("\(viewModel.activities.count)")
                    Text("")

                }
                GridRow() {
                    Text("Distance")
                    Text("\(viewModel.activities.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue).formatDistanceDisplayValue())")
                    Text("\((viewModel.activities.sumDistances() / Double(viewModel.activities.count)).convertMetersToDistanceUnit(DistanceUnit.miles.rawValue).formatDistanceDisplayValue())")
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(.red)
        .padding()
    }
}
