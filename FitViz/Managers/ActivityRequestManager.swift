//
//  ActivityRequestManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

struct ActivityRequestManager {
    let networkManager = NetworkManager()
    let cloudkitManager = CloudKitManager()
    
    // TODO: Change this to be a generic, probably should be a protocol type that all the activities inherit from
    func getActivities(source: Source, completed: @escaping (Result<[StravaActivity], Error>) -> ()) {
        cloudkitManager.getSourceInformation(source: source) { result in
            switch result {
            case .success(let result):
                print("success with the source info ")
                let lastFetchTime = result?.lastFetched ?? 0
                var urlString = ""
                switch source {
                case .Strava:
                    urlString = "https://www.strava.com/api/v3/athlete/activities"
                    if lastFetchTime != 0 {
                        print("it's not zero")
                        urlString += "?after=\(lastFetchTime)"
                    } else {
                        //TODO: Change this to get pagination done properly. For now I'll just load in a lot of activities
//                        urlString += "?page_limit=100"
                        print("last fetch time is zero")
                        urlString += "?page_limit=20"
                    }
                case .MapMyRun:
                    urlString = "TBD"
                }
                guard let url = URL(string: urlString) else {
                    completed(.failure(CustomError.urlStringInvalid))
                    return
                }
                var urlRequest = URLRequest(url: url)
                switch source {
                    // TODO change this to get the token from nsuserdefaults or wherever I'm going to write it to
                case .Strava:
                    // TODO: Throw an error if there is no access code?
                    if let token = KeychainManager.shared.getStravaAccessCode() {
                        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                    }
                case .MapMyRun:
                    print("No map my run token yet")
                }
                // TODO: Handle the pagination where we continue to make requests if we reach the page size
                networkManager.getRequest(urlRequest: urlRequest, completed: completed)
            case .failure(let error):
                print(error)
            }
        }


    }
    
    //
}
