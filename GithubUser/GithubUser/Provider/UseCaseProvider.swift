//
//  UseCaseProvider.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation

protocol UseCaseProvider {
    func makeUserUseCase() -> UserUseCase
    func makeUserDetailUseCase() -> UserDetailUseCase
}

struct DefaultsUseCaseProvider: UseCaseProvider {

    let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func makeUserUseCase() -> UserUseCase {
        let service = GithubService(apiClient)
        return DefaultUsersUseCase(repository: service)
    }

    func makeUserDetailUseCase() -> UserDetailUseCase {
        let service = GithubService(apiClient)
        return DefaultUserDetailUseCase(repository: service)
    }
}
