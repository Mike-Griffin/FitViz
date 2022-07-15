//
//  ActivityListView.swift
//  FitViz
//
//  Created by Mike Griffin on 5/7/22.
//

import SwiftUI

struct ActivityListView: View {
    @Binding var activities: [FVActivity]
    var body: some View {
        List(activities) { activity in
            NavigationLink {
                ActivityView(viewModel: ActivityView.ViewModel(activity: activity))
            } label: {
                ActivityListCellView(activity: activity)
            }
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView(activities: .constant([]))
    }
}
