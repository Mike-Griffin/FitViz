//
//  StatsView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/4/22.
//

import SwiftUI

struct StatsView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            Form {
                DatePicker(
                    "Start Date",
                    selection: $viewModel.startDate.onChange(viewModel.userSelectedDate),
                    displayedComponents: [.date]
                )
                DatePicker(
                    "End Date",
                    selection: $viewModel.endDate.onChange(viewModel.userSelectedDate),
                    displayedComponents: [.date]
                )
                Picker("Type", selection: $viewModel.selectedActivityType.onChange(viewModel.userSelectedType)) {
                    ForEach(viewModel.availableTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
            }
            ScrollView {
                // TODO: This will be the container which shows all the charts
                PreviousWeeksChartView(viewModel: PreviousWeeksChartView.ViewModel(activities: viewModel.activities))
                TimeOfDayView(viewModel: TimeOfDayView.ViewModel(activities: viewModel.activities))

            }
            VStack {
                Text("Stats")
                MostCommonDayView(viewModel: MostCommonDayView.ViewModel(activities: viewModel.activities))
                Text(viewModel.activities.first?.type ?? "nada")
                Text("There are \($viewModel.activities.count) activities!")
                ActivityListView(activities: viewModel.activities)
            }
            Spacer()
        }
        .onAppear {
            viewModel.viewAppears()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
