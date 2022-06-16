//
//  UserDetailNavigator.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit

protocol UserDetailNavigator {
    func pop()
}

struct DefaultUserDetailNavigator: UserDetailNavigator {

    let navi: UINavigationController?

    init(navi: UINavigationController?) {
        self.navi = navi
    }

    func pop() {
        navi?.popViewController(animated: true)
    }
}
