//
//  DefaultUserNavigator.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import UIKit

protocol UserNavigator {
    func moveToUserDetail(userDTO: User)
}
