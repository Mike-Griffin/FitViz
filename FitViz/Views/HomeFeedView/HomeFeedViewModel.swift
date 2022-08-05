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
        @Published var loading = false
        func loadActivities() {
            loading = true
            Task {
                do {
                    feedActivities = try await ckManager.loadActivities()
                    loading = false
                } catch {
                    print(error.localizedDescription)
                    print("TODO: Display an alert")
                    loading = false
                }
            }

        }
    }
}
