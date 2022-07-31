//
//  UsersViewModel.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import Extensions
import ViewModelType

final class UsersViewModel: ViewModelType {

    private let navigator: UserNavigator
    private let useCase: UserUseCase

    init(navigator: UserNavigator, useCase: UserUseCase) {
        self.useCase = useCase
        self.navigator = navigator
    }

    // MARK: - Input
    struct Input {
        let trigger: Driver<Void>
        let refresh: Driver<Void>
        let selected: Driver<IndexPath>
    }

    // MARK: - Output
    struct Output {
        var users: Driver<[User]>
        var error: Driver<NetworkError>
        var itemSelected: Driver<User>
    }

    func transform(input: Input) -> Output {
        // Input
        let fetchUsers = Driver.merge([input.trigger, input.refresh])
            .asObservable()
            .flatMapLatest(useCase.fetchUsers)

        // Output
        let users = fetchUsers.onSuccess()
        let error = fetchUsers.onFailure()

        let itemSelected = input.selected
            .asObservable()
            .withLatestFrom(users) { indexPath, users in users[indexPath.row] }
            .do(onNext: { [weak self] userDTO in
                self?.navigator.moveToUserDetail(userDTO: userDTO)
            })

        return .init(
            users: users.asDriverOnEmpty(),
            error: error.asDriverOnEmpty(),
            itemSelected: itemSelected.asDriverOnEmpty()
        )
    }
}
