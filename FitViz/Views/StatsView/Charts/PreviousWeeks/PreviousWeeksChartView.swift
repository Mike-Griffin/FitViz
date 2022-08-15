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
        VStack {
            Chart {
                ForEach(0...11, id: \.self) { i in
                    LineMark(
                        x: .value("Week Number", i),
                        y: .value("Duration", viewModel.animateMap[i] == 2
                                  ? viewModel.activityMap[i]?.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue) ?? 0
                                  : 0)
                    )
                    .symbol(Circle().strokeBorder(lineWidth: 2))
                    .symbolSize(60)
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

            // TODO: Need to broadcast the update
            //
            Button {
                animateGraph()
            } label: {
                Text("Animate")
            }

        }
         

    }
    
    func animateGraph() {
        print("animations here")
        print("Activity count \(viewModel.activities.count)")
        print("Activity map count \(viewModel.activityMap.count)")
            for index in 0 ..< 12 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                    withAnimation(.interactiveSpring(response:  0.8, dampingFraction: 0.8)) {
                        viewModel.animateMap[index] = 2
                    }
                }
            }
    }
}

struct PreviousWeeksChartView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousWeeksChartView(viewModel: PreviousWeeksChartView.ViewModel(activities: [FVActivity(record: MockData.activity)]))
    }
}
