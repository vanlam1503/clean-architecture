//
//  UserNavigator.swift
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

    init(navi: UINavigationController?) {
        self.navi = navi
    }

    func moveToUserDetail(userDTO: UserDTO) {

    }
}
