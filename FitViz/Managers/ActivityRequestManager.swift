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
    
    func getActivities(source: Source, urlString: String) async throws -> [StravaActivity] {
        guard let url = URL(string: urlString) else {
            throw(CustomError.urlStringInvalid)
        }
        var urlRequest = URLRequest(url: url)
        switch source {
        case .Strava:
            // TODO: Throw an error if there is no access code?
            if let token = KeychainManager.shared.getStravaAccessCode() {
                urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        case .MapMyRun:
            print("No map my run token yet")
        }
        return try await networkManager.getRequest(urlRequest: urlRequest)
    }
    
}
