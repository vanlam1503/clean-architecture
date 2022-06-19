//
//  UseCaseProvider.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import UserDetail

protocol UseCaseProvider {
    func makeUserUseCase() -> UserUseCase
    func makeUserDetailUseCase() -> UserDetailUseCase
}

struct DefaultsUseCaseProvider: UseCaseProvider {

    private let apiClient: ApiClient
    private let cache: ResponseCache.Type

    init(apiClient: ApiClient, cache: ResponseCache.Type) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func makeUserUseCase() -> UserUseCase {
        let service = GithubService(apiClient.rx)
        return DefaultUsersUseCase(repository: service, cache: cache)
    }

    func makeUserDetailUseCase() -> UserDetailUseCase {
        let service = GithubService(apiClient.rx)
        return DefaultUserDetailUseCase(repository: service, cache: cache)
    }
}
