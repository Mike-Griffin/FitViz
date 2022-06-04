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
                Text(String(activity.distance))
                Text(distanceUnit)
                Text(activity.type)
            }
            HStack {
                Text("via \(activity.source)")
            }
        }
    }
}

struct ActivityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListCellView(activity: .constant(FVActivity(record: MockData.activity)))
    }
}
