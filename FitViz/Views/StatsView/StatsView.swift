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
        ScrollView {
            FilterActivitiesFormView(viewModel: viewModel)
            VStack(alignment: .leading) {
                Text("Charts")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                PreviousWeeksChartView(viewModel: viewModel )

                TimeOfDayView(viewModel: TimeOfDayView.ViewModel(activities: viewModel.activities))


            }
            VStack {
                Text("Stats")
                MostCommonDayView(viewModel: MostCommonDayView.ViewModel(activities: viewModel.activities))
                Text(viewModel.activities.first?.type ?? "nada")
                Text("There are \($viewModel.activities.count) activities!")
                ActivityListView(activities: viewModel.activities)
                if (viewModel.longestActivity != nil) {
                    
                    Text("Longest activity distance is \(viewModel.longestActivity!.distance.convertMetersToDistanceUnit(DistanceUnit.miles.rawValue)) miles")
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.viewAppears()
        }
    }
}

struct FilterActivitiesFormView: View {
    @ObservedObject var viewModel: StatsView.ViewModel
    var body: some View {
        VStack {
            Button {
                viewModel.hideForm.toggle()
            } label: {
                HStack {
                    Text("Filter Activities")
                        .font(.headline)
                    Image(systemName: viewModel.hideForm ? "chevron.down" : "chevron.up")
                        .frame(width: 8, height: 8)
                    Spacer()
                }
                .foregroundColor(.primary)
            }

            if(!viewModel.hideForm) {
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
                .frame(height: 200)
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
