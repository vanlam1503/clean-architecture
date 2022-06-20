//
//  UsersUseCase.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Extensions

protocol UserUseCase {
    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>>
}

struct DefaultUsersUseCase: UserUseCase {

    private let repository: GithubServiceRepository
    private let cache: ResponseCache.Type

    init(repository: GithubServiceRepository, cache: ResponseCache.Type) {
        self.repository = repository
        self.cache = cache
    }

    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>> {
        let key = App.ResponseCacheKey.users
        return repository
            .fetchUsers()
            .cache(key: key, storeAt: cache)
            .getCache(key: key, storedAt: cache)

    }
}
