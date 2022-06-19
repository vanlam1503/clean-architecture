//
//  User.swift
//  UserDetail
//
//  Created by Lam Le V. on 6/18/22.
//

import Foundation
import Extensions

public protocol User: Mapper {
    var login: String { get set }
    var githubProfile: String { get set }
    var avatar: String { get set }
    var location: String { get set }
    var bio: String { get set }
    var publicRepos: Int { get set }
    var followers: Int { get set }
    var following: Int { get set }
    var name: String { get set }
}
