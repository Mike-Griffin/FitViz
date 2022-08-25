//
//  HomeFeedView.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import SwiftUI

struct HomeFeedView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        ZStack {
        VStack {
            if viewModel.feedActivities.isEmpty {
                Text("No activities yet")
            } else {
                SnapshotView(viewModel: SnapshotViewModel(activities: viewModel.snapshotActivities, header: "10 day snapshot"))
                ActivityListView(activities: viewModel.feedActivities)
            }
        }
            if (viewModel.loading) {
                LoadingView()
            }
        }
            .onAppear {
                viewModel.loadActivities()
            }
    }
}

struct HomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView()
    }
}
