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
        return apiClient.rx.makeCall(router).map { result in
            switch result {
            case .success(let data):
                let userDTOs = try! JSONDecoder().decode([UserDTO].self, from: data)
                return .success(userDTOs)
            case .failure(let error):
                return .failure(error)
            }
        }
    }

    func fetchUserDetail(login: String) -> Observable<Result<UserDTO, NetworkError>> {
        let router = GithubRouter.user(login: login)
        return apiClient.rx.makeCall(router).map { result in
            switch result {
            case .success(let data):
                let userDTO = try! JSONDecoder().decode(UserDTO.self, from: data)
                return .success(userDTO)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
