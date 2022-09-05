//
//  ActivityDetailsView.swift
//  FitViz
//
//  Created by Mike Griffin on 9/3/22.
//

import SwiftUI

struct ActivityDetailsView: View {
    @ObservedObject var viewModel: ActivityView.ViewModel
    var body: some View {
        HStack(spacing: 24) {
                ZStack {
                    Circle()
                        .foregroundColor(Color(red: 0/255, green: 67/255, blue: 13/255))
                        .frame(width: 64, height: 64)
                    ActivityIcon(activityString: viewModel.activity.type, size: 42)
//                        .frame(width: 52, height: 52)
                        .foregroundColor(.green)

                }
            VStack(spacing: 20) {
                HStack {
                    DetailItemView(numberDisplay: viewModel.activityDisplayString, captionDisplay: "\(viewModel.distanceUnit) \(viewModel.activity.type.lowercased())")
                    Spacer()
                    DetailItemView(numberDisplay: "\(viewModel.activityTimeDisplayString)", captionDisplay: "start time")
                }
                HStack {
                    DetailItemView(numberDisplay: "\(viewModel.milePace)", captionDisplay: "average pace/mi")
                    Spacer()
                    DetailItemView(numberDisplay: "\(viewModel.activity.averageHeartRate.formatDoubleDisplayValue())", captionDisplay: "average heart rate/ bpm")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailsView(viewModel: ActivityView.ViewModel(activity: FVActivity(record: MockData.activity)))
    }
}

struct DetailItemView: View {
    var numberDisplay: String
    var captionDisplay: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(numberDisplay)
                .font(.largeTitle)
                .bold()
            Text(captionDisplay)
                .font(.caption)
        }
    }
}
