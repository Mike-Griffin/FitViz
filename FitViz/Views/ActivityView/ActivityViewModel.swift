//
//  ActivityViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 7/14/22.
//

import Foundation

extension ActivityView {
    class ViewModel: ObservableObject {
        var activity: FVActivity
        
        init(activity: FVActivity) {
            self.activity = activity
        }
    }
}
