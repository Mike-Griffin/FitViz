//
//  AuthDetails.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import Foundation

struct AuthDetails {
    let clientId: Int
    let clientSecret: String
    // these may be something that I remove and put elsewhere
    let redirectUri: String
    let scopes: String
}

struct AuthDetailsSoure {
    static let strava = AuthDetails(clientId: 71349,
                                    clientSecret: "a8ab96b75e576a7fc7b0ea5f2a3365bba53a4e41",
                                    redirectUri: "\(Scheme.clientScheme)://mike-griffin.github.io/",
                                    scopes: "activity:read_all,profile:read_all"
)
    static let mapMyRun = AuthDetails(clientId: 0, clientSecret: "", redirectUri: "", scopes: "")
}
