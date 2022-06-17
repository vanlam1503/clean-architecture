//
//  UserDetailViewModel.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class UserDetailViewModel: ViewModelType {

    private let navigator: UserDetailNavigator
    private let useCase: UserDetailUseCase
    private let userDTO: UserDTO
    private let bag = DisposeBag()

    init(navigator: UserDetailNavigator, useCase: UserDetailUseCase, userDTO: UserDTO) {
        self.navigator = navigator
        self.useCase = useCase
        self.userDTO = userDTO
    }

    struct Input {
        let trigger: Driver<Void>
    }

    struct Output {
        let userDTO: Driver<UserDTO>
        let avatar: Driver<String>
        let username: Driver<String>
        var location: Driver<String>
        let bio: Driver<String>
        let error: Driver<NetworkError>
        let publicRepos: Driver<Int>
        let followers: Driver<Int>
        let following: Driver<Int>
    }

    func transform(input: Input) -> Output {
        let userDTO: BehaviorRelay<UserDTO> = .init(value: self.userDTO)

        // Output
        let avatar = userDTO.map(\.avatar)
        let userName = userDTO.map(\.userName)
        let location = userDTO.map(\.location)
        let bio = userDTO.map(\.bio)
        let publicRepos = userDTO.map(\.publicRepos)
        let followers = userDTO.map(\.followers)
        let following = userDTO.map(\.following)

        let fetchUserDetail = input.trigger
            .asObservable()
            .withLatestFrom(userName)
            .flatMapLatest(useCase.fetchUserDetail)

        let fetchUserDetailSuccess = fetchUserDetail.onSuccess()
        let error = fetchUserDetail.onFailure()

        fetchUserDetailSuccess
            .bind(to: userDTO)
            .disposed(by: bag)

        return .init(
            userDTO: userDTO.asDriverOnEmpty(),
            avatar: avatar.asDriverOnEmpty(),
            username: userName.asDriverOnEmpty(),
            location: location.asDriverOnEmpty(),
            bio: bio.asDriverOnEmpty(),
            error: error.asDriverOnEmpty(),
            publicRepos: publicRepos.asDriverOnEmpty(),
            followers: followers.asDriverOnEmpty(),
            following: following.asDriverOnEmpty()
        )
    }
}
