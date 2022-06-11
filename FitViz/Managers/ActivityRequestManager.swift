//
//  ActivityRequestManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

struct ActivityRequestManager {
    let networkManager = NetworkManager()
    
    //TODO: Modify this function to take in the enum for the source, then switch over the source
    func getActivities(source: Source, completed: @escaping (Result<[StravaActivity], Error>) -> ()) {
        var urlString = ""
        switch source {
        case .Strava:
            urlString = "https://www.strava.com/api/v3/athlete/activities"
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
            urlRequest.addValue("Bearer 2dbb2507ac9a820b44a08e678837158eddda0d04", forHTTPHeaderField: "Authorization")
        case .MapMyRun:
            print("No map my run token yet")
        }
        networkManager.getRequest(urlRequest: urlRequest, completed: completed)
    }
    
    //
}
