//
//  GithubRouter.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import Alamofire

enum GithubRouter: Router {

    case users

    var urlString: String {
        switch self {
        case .users:
            return "/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .users:
            return HTTPMethod.get
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .users:
            return [:]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .users:
            return URLEncoding.default
        }
    }

    var parameters: Parameters {
        switch self {
        case .users:
            return [:]
        }
    }
}
