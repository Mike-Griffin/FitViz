//
//  FitVizWidget.swift
//  FitVizWidget
//
//  Created by Mike Griffin on 8/28/22.
//

import WidgetKit
import SwiftUI

struct LatestActivityProvider: TimelineProvider {
    func placeholder(in context: Context) -> LatestActivityEntry {
        LatestActivityEntry(date: Date(), activity: FVActivity(record: MockData.activity))
    }

    func getSnapshot(in context: Context, completion: @escaping (LatestActivityEntry) -> ()) {
        let entry = LatestActivityEntry(date: Date(), activity: FVActivity(record: MockData.activity))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let cloudkitManager = CloudKitManager()
        Task {
            do {
                let activity = try await cloudkitManager.fetchActivities().first ?? FVActivity(record: MockData.activity)
                let entry = LatestActivityEntry(date: .now, activity: activity)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            } catch {
                print(error)
            }
        }
    }
}

struct LatestActivityEntry: TimelineEntry {
    let date: Date
    let activity: FVActivity
}

struct LatestActivityEntryView : View {
    var entry: LatestActivityEntry

    var body: some View {
        VStack {
            Text(entry.activity.type)
            Text(entry.activity.startTime.activityPreviewDateDisplay())
        }
    }
}

struct LatestActivityWidget: Widget {
    let kind: String = "LatestActivityWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LatestActivityProvider()) { entry in
            LatestActivityEntryView(entry: entry)
        }
        .configurationDisplayName("Latest Activity")
        .description("Widget with details of most recent activity.")
        .supportedFamilies([.systemMedium])
    }
}

struct LatestActivityWidget_Previews: PreviewProvider {
    static var previews: some View {
        LatestActivityEntryView(entry: LatestActivityEntry(date: Date(), activity: FVActivity(record: MockData.activity)))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
