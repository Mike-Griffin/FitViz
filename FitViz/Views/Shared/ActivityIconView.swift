//
//  ActivityIconView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/23/22.
//

import SwiftUI

struct ActivityIcon: View {
    var activityString: String
    var size: CGFloat = 18
    var body: some View {
        VStack {
            switch(ActivityType(rawValue: activityString)) {
            case .Run:
                Image(systemName: "figure.run")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            case .Ride:
                Image(systemName: "figure.outdoor.cycle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            case .Swim:
                Image(systemName: "figure.open.water.swim")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            default:
                Image(systemName: "moon.haze")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        }
    }
}

struct ActivityIcon_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIcon(activityString: ActivityType.Run.rawValue)
    }
}
