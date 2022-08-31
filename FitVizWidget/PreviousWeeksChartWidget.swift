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
        // TODO: Clean this up and put it in a utility function
        let firstDayOfWeekTimestamp = Date().getFirstDayOfWeekTimeStamp()
        let startDateTimeStamp = firstDayOfWeekTimestamp - 11.weeksToSeconds()
        Task {
            do {
                let activities = try await CloudKitManager().fetchActivities(startDate: Date(timeIntervalSince1970: TimeInterval(startDateTimeStamp)))
                
                let entry = PreviousWeeksChartEntry(date: .now, activities: activities)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            } catch {
                print(error)
            }
        }

    }
    
}

struct PreviousWeeksChartEntry: TimelineEntry {
    let date: Date
    let activities: [FVActivity]
}

struct PreviousWeeksChartEntryView : View {
    var entry: PreviousWeeksChartEntry
    @State var animateMap: [Int: Bool] = [:]
    
    var body: some View {
        VStack {
            PreviousWeeksChartView(animateMap: $animateMap, activityMap: entry.activities.groupByWeek(), maxValue: getMaxValue(activityMap: entry.activities.groupByWeek()), dateTransitionMap: getDateTransitionMap())
        }
    }
}

func getMaxValue(activityMap: [Int: [FVActivity]]) -> Int {
    var maxValue = 0
    for (_, value) in activityMap {
        maxValue = max(maxValue, Int(value.sumDistances()))
    }
    return maxValue
}

func getDateTransitionMap() -> [Int: String] {
    var previousDate = Date().getFirstDayOfWeek()
    var dateTransitionMap: [Int: String] = [:]

    for i in 1 ..< 12 {
        let currentDate = previousDate.addingTimeInterval(TimeInterval((-1).weeksToSeconds()))

        if (previousDate.toMonth() != currentDate.toMonth()) {
            dateTransitionMap[11 - i] = previousDate.toMonth()
        }
        previousDate = currentDate
    }
    
    return dateTransitionMap
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
