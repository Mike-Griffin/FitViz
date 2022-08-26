//
//  CalendarScreenView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarScreenView: View {
    @StateObject var viewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            CalendarHeaderView(viewModel: viewModel)
            if(viewModel.intervalChecked) {
                CalendarView(
                    viewModel: viewModel
                )
            }
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
                .fontWeight(.bold)
            Grid(alignment: .leading) {
                GridRow() {
                    Text("")
                    Text("Total")
                    Text("Average")
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                GridRow() {
                    Text("Activities")
                    Text("\(viewModel.activities.count)")
                    Text("")

                }
                .frame(maxWidth: .infinity, alignment: .leading)

                GridRow() {
                    Text("Distance")
                    Text("\(viewModel.activities.sumDistances().displayInUnit(.miles))")
                    Text("\((viewModel.activities.sumDistances() / Double(viewModel.activities.count)).displayInUnit(.miles))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
        }
        .padding()
    }
}
