//
//  ContentView.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        if viewModel.defaultSource.isEmpty {
            NavigationStack {
            VStack {
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
