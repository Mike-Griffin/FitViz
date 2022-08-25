//
//  ContentView.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        if viewModel.defaultSource.isEmpty {
            NavigationView {
                ZStack {
                    VStack {
                        NavigationLink("Stats") {
                            StatsView()
                        }
                        NavigationLink("Calendar") {
                            CalendarScreenView()
                        }
                        NavigationLink("Settings") {
                            SettingsView()
                        }
                        NavigationLink("Developer") {
                            DeveloperView()
                        }
                        if (!viewModel.loading) {
                            HomeFeedView()
                        }
                    }
                    if(viewModel.loading) {
                        LoadingView()
                    }
                }
                .alert(item: $viewModel.alertItem, content: { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                })
            }
            
        } else {
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
