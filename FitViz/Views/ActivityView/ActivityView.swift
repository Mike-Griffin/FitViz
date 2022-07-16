//
//  ActivityView.swift
//  FitViz
//
//  Created by Mike Griffin on 7/14/22.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
        HStack {
            Text(viewModel.activityDisplayString)
            Text(viewModel.distanceUnit)
            Text(viewModel.activity.type)
        }
            if(!viewModel.sameDistanceActivities.isEmpty) {
                SameDistanceActivityView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchSameDistanceActivities()
        }
    }
}



//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}

struct SameDistanceActivityView: View {
    @StateObject var viewModel: ActivityView.ViewModel
    var body: some View {
        VStack {
            Text("Other \(viewModel.activity.distanceRange.description) \(viewModel.activity.type)s")
            ActivityListView(activities: viewModel.sameDistanceActivities)
        }
    }
}
