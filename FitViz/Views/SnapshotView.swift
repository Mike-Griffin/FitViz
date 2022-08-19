//
//  SnapshotView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/18/22.
//

import SwiftUI

struct SnapshotView: View {
    var activities: [FVActivity]
    var header: String
    var body: some View {
        VStack {
            Text(header)
                .font(.headline)
            Text("you've done \(activities.count) activities")
        }
    }
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView(activities: [FVActivity(record: MockData.activity)], header: "Snapshot View")
    }
}
