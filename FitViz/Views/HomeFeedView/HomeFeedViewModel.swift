//
//  HomeFeedViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import Foundation

extension HomeFeedView {
    class ViewModel: ObservableObject {
        let ckManager = CloudKitManager()
        @Published var feedActivities: [FVActivity] = []
        func loadActivities() {
            ckManager.loadActivities { [self] result in
                switch result {
                case .success(let activities):
                    feedActivities = activities
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
