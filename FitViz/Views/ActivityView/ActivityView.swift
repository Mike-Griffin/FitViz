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
            if(viewModel.activity.encodedPolyline != "N/A" && !viewModel.lineCoordinates.isEmpty && viewModel.region != nil) {
                MapView(region: viewModel.region!, lineCoordinates: viewModel.lineCoordinates)
            }
            if(!viewModel.sameDistanceActivities.isEmpty) {
                SameDistanceActivityView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchSameDistanceActivities()
            viewModel.decodePolyline()
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
            ActivitySimpleListView(activities: viewModel.sameDistanceActivities)
        }
    }
}
