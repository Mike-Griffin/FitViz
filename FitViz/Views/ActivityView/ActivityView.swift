//
//  ActivityView.swift
//  FitViz
//
//  Created by Mike Griffin on 7/14/22.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
#if DEBUG
let _ = Self._printChanges()
#endif
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
            if(viewModel.activity.encodedPolyline != "N/A" && !viewModel.lineCoordinates.isEmpty && viewModel.region != nil && viewModel.regionBuilt) {
                ZStack {
                    MapView(region: viewModel.region!, lineCoordinates: viewModel.lineCoordinates, loadingMap: $viewModel.loadingMap)
                    if(viewModel.loadingMap) {
                        LoadingView()
                    }
                }
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
    @ObservedObject var viewModel: ActivityView.ViewModel
    var body: some View {
        VStack {
            Text("Other \(viewModel.activity.distanceRange.description) \(viewModel.activity.type)s")
            ActivitySimpleListView(activities: viewModel.sameDistanceActivities, viewingActivity: viewModel.activity)
        }
    }
}
