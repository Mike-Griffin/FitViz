//
//  TokenResponse.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import Foundation

struct TokenResponse: Codable {
    let access_token: String
    let refresh_token: String
    let expires_at: Int
}
