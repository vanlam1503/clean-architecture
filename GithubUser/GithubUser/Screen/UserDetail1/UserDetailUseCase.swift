//
//  UserDetailUseCase.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserDetailUseCase {
    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>>
}

struct DefaultUserDetailUseCase: UserDetailUseCase {

    private let repository: GithubServiceRepository
    private let cache: ResponseCache.Type

    init(repository: GithubServiceRepository, cache: ResponseCache.Type) {
        self.repository = repository
        self.cache = cache
    }

    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>> {
        let key = App.ResponseCacheKey.user(login: login)
        return repository
            .fetchUserDetail(login: login)
            .cache(key: key, storeAt: cache)
            .getCache(key: key, storedAt: cache)
    }
}
