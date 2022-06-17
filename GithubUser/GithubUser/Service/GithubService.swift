//
//  GithubService.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import RxSwift
import RxCocoa
import Foundation

protocol GithubServiceRepository {
    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>>
    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>>
}

struct GithubService: GithubServiceRepository {

    private let apiClient: ApiClient

    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>> {
        let router = GithubRouter.users
        return apiClient.rx
            .makeCall(router)
            .mapObject(to: [UserDTO].self)
            .cache(key: router.urlString)
            .getCache(key: router.urlString)
    }

    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>> {
        let router = GithubRouter.user(login: login)
        return apiClient.rx
            .makeCall(router)
            .mapObject(to: UserDTO.self)
            .cache(key: router.urlString)
            .getCache(key: router.urlString)
    }
}
