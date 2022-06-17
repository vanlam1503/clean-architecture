//
//  UserDTO.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation

/// Requirement:
/// Display username, github profile’s link and avatar
struct UserDTO: Codable {

    var login: String = ""
    var githubProfile: String = ""
    var avatar: String = ""
    var location: String = ""
    var bio: String = ""
    var publicRepos: Int = 0
    var followers: Int = 0
    var following: Int = 0
    var name: String = ""

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case githubProfile = "url"
        case avatar = "avatar_url"
        case location = "location"
        case bio = "bio"
        case publicRepos = "public_repos"
        case followers = "followers"
        case following = "following"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login <- container[.login]
        githubProfile <- container[.githubProfile]
        avatar <- container[.avatar]
        location <- container[.location]
        bio <- container[.bio]
        publicRepos <- container[.publicRepos]
        followers <- container[.followers]
        following <- container[.following]
        name <- container[.name]
    }
}
