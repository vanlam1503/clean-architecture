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

    var userName: String = ""
    var githubProfile: String = ""
    var avatar: String = ""
    var location: String = ""
    var bio: String = ""
    var publicRepos: Int = 0
    var followers: Int = 0
    var following: Int = 0

    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case githubProfile = "url"
        case avatar = "avatar_url"
        case location = "location"
        case bio = "bio"
        case publicRepos = "public_repos"
        case followers = "followers"
        case following = "following"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName <- container[.userName]
        githubProfile <- container[.githubProfile]
        avatar <- container[.avatar]
        location <- container[.location]
        bio <- container[.bio]
        publicRepos <- container[.publicRepos]
        followers <- container[.followers]
        following <- container[.following]
    }
}
