//
//  CalendarScreenView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/13/22.
//

import SwiftUI

struct CalendarScreenView: View {
    @ObservedObject var viewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            Text("Calendar for the month of \(viewModel.monthDescription)!!!")
            CalendarView(
                viewModel: viewModel
            )
        }
        .sheet(isPresented: $viewModel.showSheet) {
            ActivityView(viewModel: ActivityView.ViewModel(activity: viewModel.selectedActivity!))
        }
    }
}

struct CalendarScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreenView()
    }
}
