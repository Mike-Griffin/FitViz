//
//  RootViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import SwiftUI

extension RootView {
    class ViewModel: ObservableObject {
        var defaultSource: [Source] = []
        let activityRequestManager = ActivityRequestManager()
        let authorizationManager = AuthorizationManager()
        init() {
            authorizationManager.performAuthSessionRequest(source: .Strava) { [self] result in
                switch result {
                case .success(let token):
                    if let token = token {
                        print("Token: \(token)")
                        activityRequestManager.getActivities(source: .Strava) { (result: Result<[StravaActivity], Error>) in
                            switch(result) {
                            case .success(let activities):
                                print("Great Success")
                                print(activities)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    } else {
                        print("No token :(")
                    }
                case .failure(let error):
                    print(error)
                }
            }

        }
    }
}
