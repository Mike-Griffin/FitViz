//
//  PreviousWeeksChartView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import SwiftUI
import Charts

struct PreviousWeeksChartView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Chart {
            ForEach(0...11, id: \.self) { i in
                LineMark(x: .value("Week Number", i), y: .value("Duration", viewModel.activityMap[i]?.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue) ?? 0))
            }
        }
        .chartXScale(domain: 0...11)
        .chartXAxis {
                AxisMarks(values: .stride(by: 1)) { axis in
                    AxisGridLine()
                    if let month = viewModel.dateTransitionMap[axis.index] {
                        AxisValueLabel(month)
                    }
                }
        }
        .chartYScale(domain: 0...Double(viewModel.maxValue).convertMetersToDistanceUnit(DistanceUnit.miles.rawValue))
        .frame(height: 250)
        .padding()

    }
}

struct PreviousWeeksChartView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousWeeksChartView(viewModel: PreviousWeeksChartView.ViewModel(activities: [FVActivity(record: MockData.activity)]))
    }
}
