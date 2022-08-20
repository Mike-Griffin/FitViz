//
//  SnapshotView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/18/22.
//

import SwiftUI

struct SnapshotView: View {
    @ObservedObject var viewModel: SnapshotViewModel

    var body: some View {
        VStack {
            Text(viewModel.header)
                .font(.headline)
            Text("you've done \(viewModel.activities.count) activities")
            Text("Longest streak \(viewModel.longestStreak) days")
        }
    }
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView(viewModel: SnapshotViewModel(activities: [FVActivity(record: MockData.activity)], header: "Snapshot View"))
    }
}
