//
//  StatsView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/4/22.
//

import SwiftUI

struct StatsView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
        Text("Stats")
            Text(viewModel.activities.first?.type ?? "nada")
            Text(viewModel.mostCommonDay)
        }
        .onAppear {
            viewModel.loadActivities()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
