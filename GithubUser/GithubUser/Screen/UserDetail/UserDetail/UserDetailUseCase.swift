//
//  UserDetailUseCase.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

public protocol UserDetailUseCase {
    func fetchUserDetail(login: String) -> Observable<Result<User, NetworkError>>
}
