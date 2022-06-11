//
//  ActivityRequestManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

struct ActivityRequestManager {
    let networkManager = NetworkManager()
    func getActivities(urlString: String, completed: @escaping (Result<[StravaActivity], Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            completed(.failure(CustomError.urlStringInvalid))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer 2dbb2507ac9a820b44a08e678837158eddda0d04", forHTTPHeaderField: "Authorization")
        networkManager.getRequest(urlRequest: urlRequest, completed: completed)
    }
}
