//
//  Api.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation

struct Api {
    static let baseURL = "https://api.github.com"
}

infix operator / : AdditionPrecedence

private func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}
