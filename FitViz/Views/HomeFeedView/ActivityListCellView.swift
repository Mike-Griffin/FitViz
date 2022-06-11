//
//  ActivityListCellView.swift
//  FitViz
//
//  Created by Mike Griffin on 5/24/22.
//

import SwiftUI

struct ActivityListCellView: View {
    @Binding var activity: FVActivity
    @AppStorage("distanceUnit") private var distanceUnit = ""
    var body: some View {
        VStack {
            HStack {
                Text(activity.distance      .convertMetersToDistanceUnit(distanceUnit)
                    .formatDistanceDisplayValue())
                Text(distanceUnit)
                Text(activity.type)
                ActivityIcon(activityString: activity.type)
            }
            HStack {
                Text("\(activity.startTime.activityPreviewDateDisplay()) via \(activity.source)")
            }
        }
    }
}

struct ActivityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListCellView(activity: .constant(FVActivity(record: MockData.activity)))
    }
}

struct ActivityIcon: View {
    var activityString: String
    var body: some View {
        VStack {
            switch(ActivityType(rawValue: activityString)) {
            case .Run:
                Image(systemName: "figure.walk")
            case .Bike:
                Image(systemName: "bicycle")
            default:
                Image(systemName: "face.smiling")

            }
        }
    }
}
