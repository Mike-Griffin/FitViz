//
//  FitVizWidget.swift
//  FitVizWidget
//
//  Created by Mike Griffin on 8/28/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ActivityEntry {
        ActivityEntry(date: Date(), activity: FVActivity(record: MockData.activity))
    }

    func getSnapshot(in context: Context, completion: @escaping (ActivityEntry) -> ()) {
        let entry = ActivityEntry(date: Date(), activity: FVActivity(record: MockData.activity))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let cloudkitManager = CloudKitManager()
        Task {
            do {
                let activity = try await cloudkitManager.fetchActivities().first ?? FVActivity(record: MockData.activity)
                let entry = ActivityEntry(date: .now, activity: activity)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            } catch {
                print(error)
            }
        }
    }
}

struct ActivityEntry: TimelineEntry {
    let date: Date
    let activity: FVActivity
}

struct FitVizWidgetEntryView : View {
    var entry: ActivityEntry

    var body: some View {
        VStack {
            Text(entry.activity.type)
            Text(entry.activity.startTime.activityPreviewDateDisplay())
        }
    }
}

@main
struct FitVizWidget: Widget {
    let kind: String = "FitVizWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FitVizWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct FitVizWidget_Previews: PreviewProvider {
    static var previews: some View {
        FitVizWidgetEntryView(entry: ActivityEntry(date: Date(), activity: FVActivity(record: MockData.activity)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
