//
//  ActivityListCellView.swift
//  FitViz
//
//  Created by Mike Griffin on 5/24/22.
//

import SwiftUI

struct ActivityListCellView: View {
    @Binding var activity: FVActivity
    var body: some View {
        Text(activity.startTime)
    }
}

struct ActivityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListCellView(activity: .constant(FVActivity(record: MockData.activity)))
    }
}
