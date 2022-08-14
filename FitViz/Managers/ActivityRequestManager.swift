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
//    func getActivities(source: Source) async throws -> [StravaActivity] {
//        let sourceInfo = try await cloudkitManager.getSourceInformation(source: source)
//        let lastFetchTime = sourceInfo?.lastFetched ?? 0
//        var urlString = ""
//        switch source {
//        case .Strava:
//            urlString = "https://www.strava.com/api/v3/athlete/activities"
//            if lastFetchTime != 0 {
//                print("it's not zero")
//                urlString += "?after=\(lastFetchTime)"
//                return try await makeRequest(source: source, urlString: urlString)
//            } else {
//                //TODO: Change this to get pagination done properly. For now I'll just load in a lot of activities
////                        urlString += "?page_limit=100"
//                print("last fetch time is zero")
//                urlString += "?per_page=100"
//                do {
//                    var fetchedActivities = try await makeRequest(source: source, urlString: urlString)
//                    var activities = fetchedActivities
//                    let originalString = urlString
//                    var page = 1
//                    // TODO: Remove this safeguard
//                    while (fetchedActivities.count == 100 && page < 10) {
//                        page += 1
//                        urlString = originalString + "&page=\(page)"
//                        print(page)
//                        print(fetchedActivities.count)
//                        fetchedActivities = try await makeRequest(source: source, urlString: urlString)
//                        activities.append(contentsOf: fetchedActivities)
//                    }
//                    return activities
//                } catch {
//                    print(error)
//                }
//                
//            }
//        case .MapMyRun:
//            urlString = "TBD"
//            return try await makeRequest(source: source, urlString: urlString)
//        }
//        throw(CustomError.invalidSource)
//    }

func getActivities(source: Source, urlString: String) async throws -> [StravaActivity] {
    guard let url = URL(string: urlString) else {
        throw(CustomError.urlStringInvalid)
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
    return try await networkManager.getRequest(urlRequest: urlRequest)
    }

}
