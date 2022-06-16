//
//  Api.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation

@propertyWrapper
struct Api {

    private let baseURL = "https://api.github.com"
    private let path: String

    init(path: String) {
        self.path = path
    }

    var wrappedValue: String {
        return baseURL / path
    }

    // Define
    @Api(path: "users") static var users
}

infix operator / : AdditionPrecedence

private func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}
