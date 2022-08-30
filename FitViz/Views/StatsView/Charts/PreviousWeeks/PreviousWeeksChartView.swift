//
//  PreviousWeeksChartView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/11/22.
//

import SwiftUI
import Charts

struct PreviousWeeksChartView: View {
//    @ObservedObject var viewModel: StatsView.ViewModel
    @Binding var animateMap: [Int: Bool]
    var activityMap: [Int: [FVActivity]]
    var maxValue: Int
    var dateTransitionMap: [Int: String]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(.secondarySystemBackground))
                .padding()
            VStack(alignment: .leading) {
                Text("Previous 3 Months Activity")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Chart {
                    ForEach(0...11, id: \.self) { i in
                        LineMark(
                            x: .value("Week Number", i),
                            y: .value("Duration", animateMap[i] == true
                                      ? activityMap[i]?.sumDistances().convertMetersToDistanceUnit(DistanceUnit.miles.rawValue) ?? 0
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
                        if let month = dateTransitionMap[axis.index] {
                            AxisValueLabel(month)
                        }
                    }
                }
                .chartYScale(domain: 0...Double(maxValue).convertMetersToDistanceUnit(DistanceUnit.miles.rawValue))
                .frame(height: 250)
//                .clipShape(RoundedRectangle(cornerRadius: 16))
                .onChange(of: activityMap) { newValue in
                    for i in 0 ..< 12 {
                        animateMap[i] = false
                    }
                    animateGraph()
                }
            }
            .padding()
        }
    }
    
    func animateGraph() {
        for index in 0 ..< 12 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                withAnimation(.interactiveSpring(response:  0.8, dampingFraction: 0.8)) {
                    animateMap[index] = true
                }
            }
        }
    }
}

//struct PreviousWeeksChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviousWeeksChartView(viewModel: PreviousWeeksChartView.ViewModel(activities: [FVActivity(record: MockData.activity)]))
//    }
//}
