//
//  NetworkError+Extensions.swift
//  GithubUserTests
//
//  Created by Lam Le on 17/06/2022.
//

import Foundation
@testable import GithubUser

extension NetworkError: Equatable {

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, .invalidUrl),
            (.disconnect, .disconnect),
            (.timeout, .timeout),
            (.cancel, .cancel),
            (.noResponse, .noResponse):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
