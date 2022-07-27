//
//  NetworkManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation
import SwiftUI

struct NetworkManager {
    func getRequest<T: Decodable>(urlRequest: URLRequest, completed: @escaping (Result<T, Error>) -> ()) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    completed(.failure(CustomError.getResponseErrorCode(code: httpResponse.statusCode)))
                    return
                }
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completed(.success(result))
                } catch {
                    completed(.failure(error))
                }
            }
        }.resume()

    }
    
    func getRequest<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let httpResponse = response as? HTTPURLResponse {
            guard httpResponse.statusCode == 200 else {
                throw(CustomError.getResponseErrorCode(code: httpResponse.statusCode))
            }
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
