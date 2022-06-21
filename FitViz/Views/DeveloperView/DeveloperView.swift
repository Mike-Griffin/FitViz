//
//  DeveloperView.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject private var viewModel = ViewModel()
    var body: some View {
        Form {
            FormRow(value: $viewModel.stravaAccessCode,
                    label: "Strava Access Code",
                    setValue: viewModel.setStravaAccessCodeToKeychain)
            FormRow(value: $viewModel.stravaRefreshToken, label: "Strava Refresh Token", setValue: viewModel.setStravaRefreshTokenToKeychain)
            FormRow(value: $viewModel.stravaLastFetchTime, label: "Strava Last Fetch", setValue: viewModel.setStravaLastFetchTime)
            
        }
        .onAppear {
            viewModel.fetchValues()
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}

struct FormRow: View {
    @Binding var value: String
    var label: String
    var setValue: () -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(label)
                    .font(.headline)
                TextField(label, text: $value)
            }
            Button {
                print("yeah we be setting the strava code \(value)")
                setValue()
            } label: {
                Text("Set")
            }
        }
    }
}
