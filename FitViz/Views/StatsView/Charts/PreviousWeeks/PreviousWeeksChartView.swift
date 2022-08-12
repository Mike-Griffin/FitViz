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
                LineMark(x: .value("Week Number", i), y: .value("Duration", viewModel.activityMap[i]?.count ?? 0))
            }
//            ForEach(viewModel.activities) { activity in
//                LineMark(x: .value("Timestamp", activity.startTime), y: .value("Duration", activity.duration))
//            }
        }

    }
}

struct PreviousWeeksChartView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousWeeksChartView(viewModel: PreviousWeeksChartView.ViewModel(activities: [FVActivity(record: MockData.activity)]))
    }
}
