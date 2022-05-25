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
        List($activities) {
            ActivityListCellView(activity: $0)
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView(activities: .constant([]))
    }
}
