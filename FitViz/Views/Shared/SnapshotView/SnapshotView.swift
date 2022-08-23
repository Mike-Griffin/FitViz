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
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 200)
                .foregroundColor(Color(.secondarySystemBackground))
            VStack() {
                Text(viewModel.header)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 16)
                VStack(spacing: 12) {
                    Text("\(viewModel.activities.count) activities completed")
                    Text("\(viewModel.totalDistance) miles traveled")
                    Text("For a total of \(viewModel.totalDuration) hours")
                    Text("Across \(viewModel.typeMap.count) different activities")
                }
            }
        }
        .padding()
 
    }
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView(viewModel: SnapshotViewModel(activities: [FVActivity(record: MockData.activity),FVActivity(record: MockData.activity2) ], header: "Snapshot View"))
    }
}
