//
//  MostCommonTimeOfDay.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct MostCommonDayView: View {
    var viewModel: ViewModel
    var body: some View {
        VStack {
            Text("Most Common Day is \(viewModel.mostCommonDay.rawValue) with a grand total of \(viewModel.activityCount) activities")
            
        }
    }
}

//struct MostCommonTimeOfDay_Previews: PreviewProvider {
//    static var previews: some View {
//        MostCommonTimeOfDayView(activities: [FVActivity(record: MockData.activity)])
//    }
//}
