//
//  User.swift
//  UserVC
//
//  Created by Lam Le V. on 7/31/22.
//

import Foundation

public protocol User {
    var avatar: String { get }
    var login: String { get }
    var githubProfile: String { get }
}
