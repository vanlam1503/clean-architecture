//
//  AppUrlCache.swift
//  GithubUser
//
//  Created by Lam Le on 17/06/2022.
//

import Foundation

extension App {

    struct ResponseCacheKey {
        static let users = GithubRouter.users.urlString
        static func user(login: Swift.String) -> Swift.String {
            GithubRouter.user(login: login).urlString
        }
    }
}
