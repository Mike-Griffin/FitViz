//
//  WidgetBundle.swift
//  FitVizWidgetExtension
//
//  Created by Mike Griffin on 8/29/22.
//

import SwiftUI
import WidgetKit

@main
struct FitVizWidgets: WidgetBundle {
    var body: some Widget {
        LatestActivityWidget()
        PreviousWeeksChartWidget()
    }
}
