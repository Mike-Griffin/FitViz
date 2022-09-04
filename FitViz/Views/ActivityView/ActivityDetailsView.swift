//
//  ActivityDetailsView.swift
//  FitViz
//
//  Created by Mike Griffin on 9/3/22.
//

import SwiftUI

struct ActivityDetailsView: View {
    @ObservedObject var viewModel: ActivityView.ViewModel
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.activityDisplayString)
                Text(viewModel.distanceUnit)
                Text(viewModel.activity.type)
            }
            HStack {
                Text("Pace: \(viewModel.milePace)/mi")
                Text("Heart Rate: \(viewModel.activity.averageHeartRate.formatDoubleDisplayValue())")
            }
        }
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailsView(viewModel: ActivityView.ViewModel(activity: FVActivity(record: MockData.activity)))
    }
}
