//
//  UserDetailViewModel.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import ViewModelType
import Extensions

public class UserDetailViewModel: ViewModelType {

    private let useCase: UserDetailUseCase
    private let user: User
    private let bag = DisposeBag()

    public init(useCase: UserDetailUseCase, userDTO: User) {
        self.useCase = useCase
        self.user = userDTO
    }

    public struct Input {
        let trigger: Driver<Void>
    }

    public struct Output {
        let userDTO: Driver<User>
        let avatar: Driver<String>
        let username: Driver<String>
        var location: Driver<String>
        let bio: Driver<String>
        let error: Driver<Error>
        let publicRepos: Driver<Int>
        let followers: Driver<Int>
        let following: Driver<Int>
    }

    public func transform(input: Input) -> Output {
        let userDTO: BehaviorRelay<User> = .init(value: self.user)

        // Output
        let avatar = userDTO.map(\.avatar)
        let userName = userDTO.map(\.login)
        let location = userDTO.map(\.location)
        let bio = userDTO.map { userDTO -> String in
            if userDTO.bio.isEmpty {
                return "[No Information]"
            } else {
                return userDTO.bio
            }
        }
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
