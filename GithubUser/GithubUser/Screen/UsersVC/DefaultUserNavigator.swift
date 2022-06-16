//
//  DefaultUserNavigator.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import UIKit

protocol UserNavigator {
    func moveToUserDetail(userDTO: UserDTO)
}

struct DefaultUserNavigator: UserNavigator {

    private let navi: UINavigationController?
    private let useCaseProvider: UseCaseProvider

    init(navi: UINavigationController?, useCaseProvider: UseCaseProvider) {
        self.navi = navi
        self.useCaseProvider = useCaseProvider
    }

    func moveToUserDetail(userDTO: UserDTO) {
        let navigator = DefaultUserDetailNavigator(navi: navi)
        let userCase = useCaseProvider.makeUserDetailUseCase()
        let viewModel = UserDetailViewModel(navigator: navigator, useCase: userCase, userDTO: userDTO)
        let vc = UserDetailViewController(viewModel: viewModel)
        navi?.pushViewController(vc, animated: true)
    }
}
