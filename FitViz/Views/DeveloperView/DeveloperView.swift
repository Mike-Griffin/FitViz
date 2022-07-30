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
        VStack {
            Form {
                FormRow(value: $viewModel.stravaAccessCode,
                        label: "Strava Access Code",
                        setValue: viewModel.setStravaAccessCodeToKeychain)
                FormRow(value: $viewModel.stravaRefreshToken, label: "Strava Refresh Token", setValue: viewModel.setStravaRefreshTokenToKeychain)
                FormRow(value: $viewModel.stravaLastFetchTime, label: "Strava Last Fetch", setValue: viewModel.setStravaLastFetchTime)
                Button {
                    viewModel.deleteAllActivities()
                } label: {
                    Text("Delete all Activities")
                }
            }
            
            Form {
                TextField("Center Latitude", text: $viewModel.centerLatitude)
                TextField("Center Longitude", text: $viewModel.centerLongitude)
                TextField("Latitude Delta", text: $viewModel.latitudeDelta)
                TextField("Longitude Delta", text: $viewModel.longitudeDelta)
                Button {
                    viewModel.setRegion()
                } label: {
                    Text("Set Region")
                }
            }
        }
        .onAppear {
            viewModel.fetchValues()
        }
        .sheet(isPresented: $viewModel.showingMap) {
            MapSheetView(region: viewModel.region!, presented: $viewModel.showingMap)
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
