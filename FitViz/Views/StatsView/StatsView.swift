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
            VStack {
                Text("Stats")
                Text(viewModel.activities.first?.type ?? "nada")
                Text(viewModel.mostCommonDay)
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
