//
//  UsersUseCase.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Extensions

enum NetworkError: Error {}

protocol UserUseCase {
    func fetchUsers() -> Observable<Result<[User], NetworkError>>
}
