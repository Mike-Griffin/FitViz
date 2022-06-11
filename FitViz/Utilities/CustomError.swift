//
//  CustomError.swift
//  FitViz
//
//  Created by Mike Griffin on 6/11/22.
//

import Foundation

enum CustomError: Error {
    case urlStringInvalid
case getResponseErrorCode(code: Int)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlStringInvalid:
            return NSLocalizedString("String is not a valid URL", comment: "URL String Invalid")
        case .getResponseErrorCode(code: _):
            return NSLocalizedString("Error with get request", comment: "GET Response Error")
        }
    }
}
