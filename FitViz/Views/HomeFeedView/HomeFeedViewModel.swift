//
//  HomeFeedViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import Foundation

extension HomeFeedView {
    @MainActor class ViewModel: ObservableObject {
        let ckManager = CloudKitManager()
        @Published var feedActivities: [FVActivity] = []
        func loadActivities() {
            Task {
                do {
                    feedActivities = try await ckManager.loadActivities()
                }
            }

        }
    }
}
