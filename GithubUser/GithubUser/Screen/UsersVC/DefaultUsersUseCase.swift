//
//  UsersUseCase.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserUseCase {
    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>>
}

struct DefaultUsersUseCase: UserUseCase {

    let repository: GithubServiceRepository

    init(repository: GithubServiceRepository) {
        self.repository = repository
    }

    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>> {
        let key = App.ResponseCacheKey.users
        return repository
            .fetchUsers()
            .cache(key: key)
            .getCache(key: key)

    }
}
