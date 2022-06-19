//
//  GithubService.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import RxSwift
import RxCocoa
import Foundation
import Extensions

protocol GithubServiceRepository {
    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>>
    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>>
}

struct GithubService: GithubServiceRepository {

    private let apiClient: ApiClientService

    init(_ apiClient: ApiClientService) {
        self.apiClient = apiClient
    }

    func fetchUsers() -> Observable<Result<[UserDTO], NetworkError>> {
        let router = GithubRouter.users
        return apiClient
            .makeCall(router)
            .mapObject(to: [UserDTO].self)
    }

    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>> {
        let router = GithubRouter.user(login: login)
        return apiClient
            .makeCall(router)
            .mapObject(to: UserDTO.self)
    }
}

extension Collection where Self: Mapper {
    
}
