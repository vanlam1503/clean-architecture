//
//  GithubServiceTests.swift
//  GithubUserTests
//
//  Created by Lam Le on 17/06/2022.
//

import XCTest
import RxBlocking

@testable import GithubUser

final class GithubServiceTests: XCTestCase {

    private var githubService: GithubService!

    override func setUpWithError() throws {
    }

    func testUrlStringWithUserIDIsTwo() {
        let service = MockApiClient(stubData: .success(Dummy.data))
        githubService = GithubService(service)
        _ = githubService.fetchUserDetail(login: Dummy.userID)
        expect(service.router.urlString) == "https://api.github.com/users/2"
    }

    func testResponseSuccess() {
        let service = MockApiClient(stubData: .success(Dummy.data))
        githubService = GithubService(service)
        let result = githubService.fetchUserDetail(login: Dummy.userID).toBlocking().firstOrNil()!
        switch result {
        case .success(let userDTO):
            expect(userDTO.login) == "2"
            expect(userDTO.name) == "hello"
            expect(userDTO.followers) == 5
        case .failure(let error):
            fail(error.localizedDescription)
        }
    }

    func testResponseFailure() {
        let service = MockApiClient(stubData: .failure(Dummy.timeOut))
        githubService = GithubService(service)
        let result = githubService.fetchUserDetail(login: Dummy.userID).toBlocking().firstOrNil()!
        switch result {
        case .success:
            fail("Response should be error")
        case .failure(let error):
            expect(error) == Dummy.timeOut
        }
    }
}

// MARK: - 
extension GithubServiceTests {

    struct Dummy {
        static let userID: String = "2"
        static let timeOut = NetworkError.timeout
        static let data: Data =
        """
        {
          "login": "2",
          "id": 372966,
          "node_id": "MDQ6VXNlcjM3Mjk2Ng==",
          "avatar_url": "https://avatars.githubusercontent.com/u/372966?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/2",
          "html_url": "https://github.com/2",
          "followers_url": "https://api.github.com/users/2/followers",
          "following_url": "https://api.github.com/users/2/following{/other_user}",
          "gists_url": "https://api.github.com/users/2/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/2/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/2/subscriptions",
          "organizations_url": "https://api.github.com/users/2/orgs",
          "repos_url": "https://api.github.com/users/2/repos",
          "events_url": "https://api.github.com/users/2/events{/privacy}",
          "received_events_url": "https://api.github.com/users/2/received_events",
          "type": "User",
          "site_admin": false,
          "name": "hello",
          "company": null,
          "blog": "",
          "location": null,
          "email": null,
          "hireable": null,
          "bio": null,
          "twitter_username": null,
          "public_repos": 5,
          "public_gists": 0,
          "followers": 5,
          "following": 15,
          "created_at": "2010-08-23T03:16:51Z",
          "updated_at": "2022-05-30T09:06:03Z"
        }
        """.data(using: .utf8)!
    }
}
