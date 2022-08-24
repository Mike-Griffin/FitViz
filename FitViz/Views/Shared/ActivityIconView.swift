//
//  ActivityIconView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/23/22.
//

import SwiftUI

struct ActivityIcon: View {
    var activityString: String
    var body: some View {
        VStack {
            switch(ActivityType(rawValue: activityString)) {
            case .Run:
                Image(systemName: "figure.run")
            case .Ride:
                Image(systemName: "figure.outdoor.cycle")
            case .Swim:
                Image(systemName: "figure.open.water.swim")
            default:
                Image(systemName: "moon.haze")
            }
        }
    }
}

struct ActivityIcon_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIcon(activityString: ActivityType.Run.rawValue)
    }
}
