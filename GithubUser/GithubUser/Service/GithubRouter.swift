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
    case user(login: String)

    var path: String {
        switch self {
        case .users:
            return "/users"
        case .user(let login):
            return  "/users/\(login)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .users, .user:
            return HTTPMethod.get
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .users, .user:
            return [:]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .users, .user:
            return URLEncoding.default
        }
    }

    var parameters: Parameters {
        switch self {
        case .users, .user:
            return [:]
        }
    }
}
