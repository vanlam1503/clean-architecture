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

    let repository: GithubServiceRepository

    init(repository: GithubServiceRepository) {
        self.repository = repository
    }

    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>> {
        let key = App.ResponseCacheKey.user(login: login)
        return repository
            .fetchUserDetail(login: login)
            .cache(key: key)
            .getCache(key: key)
    }
}
