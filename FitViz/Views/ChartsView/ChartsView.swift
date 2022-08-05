//
//  ChartsView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/4/22.
//

import SwiftUI
import Charts

struct ChartsView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Hello you have \(viewModel.activities.count) activities")
            Chart {
                ForEach(viewModel.activities) { activity in
                    LineMark(
                        x: .value("Start Time", activity.startTime),
                        y: .value("Duration", activity.duration)
                    )
                }
            }
        }
        
    }
}

//struct ChartsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartsView()
//    }
//}
