//
//  ActivitySimpleListView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/23/22.
//

import SwiftUI

struct ActivitySimpleListView: View {
    var activities: [FVActivity]
    var viewingActivity: FVActivity?
    var body: some View {
        List(activities) { activity in
            VStack {
                HStack {
                    ActivityIcon(activityString: activity.type)

                    Text(activity.startTime.startTimeToMMDDYY())
                }
                HStack {
                    Text("\(activity.distance.displayInUnit(.miles)) miles")
                    Text("\(activity.averagePace.metersPerSecondToDisplayValue())/mi")
                }
            }
            .foregroundColor(viewingActivity == activity ? Color(.systemRed) : Color(uiColor: .label))
        }
    }
}

struct ActivitySimpleListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySimpleListView(activities: [FVActivity(record: MockData.activity)])
    }
}