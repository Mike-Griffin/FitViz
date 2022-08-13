//
//  TimeOfDayView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI
import Charts

struct TimeOfDayView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Chart {
            ForEach(Array(viewModel.timeOfDayMap.keys), id: \.self) { key in
                BarMark(
                    x: .value("Time of Day", key.rawValue),
                    y: .value("Count", viewModel.timeOfDayMap[key] ?? 0)
                )
            }
            
        }
        .frame(height: 250)

    }
}

//struct TimeOfDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeOfDayView()
//    }
//}
