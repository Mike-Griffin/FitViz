//
//  AuthorizationManager.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import UIKit
import AuthenticationServices

class AuthorizationManager: NSObject {
    public func performAuthSessionRequest(source: Source, completed: @escaping (Result<String?, Error>) -> Void) {
        let mostOfTheString = getAuthUrl(source)
        //TODO: Move this to the authDetails
        let appOAuthUrlStravaScheme = URL(string: "strava://oauth/mobile/authorize?client_id="
                                          + mostOfTheString)!

        let webOAuthUrl = URL(string: "https://www.strava.com/oauth/mobile/authorize?client_id="
                              + mostOfTheString)!
        if UIApplication.shared.canOpenURL(appOAuthUrlStravaScheme) {
            print("ya ya")
            UIApplication.shared.open(appOAuthUrlStravaScheme, options: [:]) { result in
                print(result)
                completed(.success(nil))
            }
            print(appOAuthUrlStravaScheme.pathComponents)
            print(appOAuthUrlStravaScheme.path)
        } else {
            let authSession = ASWebAuthenticationSession(url: webOAuthUrl, callbackURLScheme: Scheme.clientScheme) { url, error in
                if let error = error {
                    print(error)
                } else {
                    print("else no error")
                    if let code = self.getCode(from: url) {
                        self.getStravaToken(code) { result in
                            switch result {
                            case .success(let tokenResponse):
//                                self?.token = tokenResponse.access_token
                                completed(.success(tokenResponse.access_token))
                            case .failure(let error):
                                completed(.failure(error))
                            }
                        }
                    }
                }
            }
            authSession.presentationContextProvider = self
            authSession.start()
        }
    }
    
    // maybe this could be moved to the enum or the authDetails struct?
    private func getAuthUrl(_ source: Source) -> String {
        let authDetails = source.getAuthDetails()
        switch(source) {
        case .Strava:
            return "\(authDetails.clientId)" +
            "&redirect_uri=" +
            authDetails.redirectUri.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            + "&response_type=code&approval_prompt=auto&scope="
            + authDetails.scopes.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            + "&state=test"
        case .MapMyRun:
            return ""
        }
    }
    
    private func getCode(from url: URL?) -> String? {
        guard let url = url?.absoluteString else { return nil }
        
        let urlComponents: URLComponents? = URLComponents(string: url)
        let code: String? = urlComponents?.queryItems?.filter { $0.name == "code" }.first?.value
        return code
    }
    
    
    // TODO: refactor this to not be Strava specific
    private func getStravaToken(_ code: String, completed: @escaping (Result<TokenResponse, Error>) -> Void) {
        let authDetails = Source.Strava.getAuthDetails()
        let json : [String: Any] = ["client_id": authDetails.clientId,
                                    "client_secret": authDetails.clientSecret,
                                    "code": code,
                                    "grant_type": "authorization_code"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        guard let url = URL(string: "https://www.strava.com/oauth/token") else {
            print("ain't no url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                let decodedData = try JSONDecoder().decode(TokenResponse.self, from: data)
//                    self.token = decodedData.access_token
                    print(decodedData.access_token)
                    print(decodedData.refresh_token)
                    print(decodedData.expires_at)
                    completed(.success(decodedData))

                }
                catch {
                   print("error decoding the token")
               }

            }
        }.resume()
    }
}

extension AuthorizationManager: ASWebAuthenticationPresentationContextProviding {
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.windows[0]
    }
}
