//
//  Application.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import UIKit

struct Application {

    let userCaseProvider: UseCaseProvider

    static let shared = Application()

    init() {
        userCaseProvider = DefaultsUseCaseProvider(apiClient: .shared)
    }

    func configure(in window: UIWindow?) {
        let navi = UINavigationController()
        let navigator = DefaultUserNavigator(navi: navi, useCaseProvider: userCaseProvider)
        let viewModel = UsersViewModel(navigator: navigator, useCase: userCaseProvider.makeUserUseCase())
        let vc = UsersViewController(viewModel: viewModel)
        navi.setViewControllers([vc], animated: false)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
}
