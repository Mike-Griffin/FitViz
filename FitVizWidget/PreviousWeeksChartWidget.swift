//
//  ChartWidget.swift
//  FitVizWidgetExtension
//
//  Created by Mike Griffin on 8/29/22.
//

import SwiftUI
import WidgetKit

struct PreviousWeeksChartProvider: TimelineProvider {
    func placeholder(in context: Context) -> PreviousWeeksChartEntry {
        PreviousWeeksChartEntry(date: Date(), activities: [FVActivity(record: MockData.activity)])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PreviousWeeksChartEntry) -> Void) {
        let entry = PreviousWeeksChartEntry(date: Date(), activities: [FVActivity(record: MockData.activity)])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PreviousWeeksChartEntry>) -> Void) {
        let entry = PreviousWeeksChartEntry(date: .now, activities: [FVActivity(record: MockData.activity)])
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
}

struct PreviousWeeksChartEntry: TimelineEntry {
    let date: Date
    let activities: [FVActivity]
}

struct PreviousWeeksChartEntryView : View {
    var entry: PreviousWeeksChartEntry

    var body: some View {
        VStack {
            Text("Hi There")
            Text("\(entry.activities.count)")
        }
    }
}

struct PreviousWeeksChartWidget: Widget {
    let kind: String = "PreviousWeeksChartWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PreviousWeeksChartProvider()) { entry in
            PreviousWeeksChartEntryView(entry: entry)
        }
        .configurationDisplayName("Previous Weeks Chart")
        .description("Widget with a chart of the last 12 weeks activities.")
        .supportedFamilies([.systemMedium])
    }
}
