//
//  ChartsViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 8/4/22.
//

import Foundation

extension ChartsView {
    class ViewModel: ObservableObject {
        let activities: [FVActivity]
        
        init(activities: [FVActivity]) {
            self.activities = activities
        }
    }
}
