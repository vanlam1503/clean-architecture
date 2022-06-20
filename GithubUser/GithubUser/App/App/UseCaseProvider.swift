//
//  UseCaseProvider.swift
//  App
//
//  Created by Lam Le V. on 6/20/22.
//

import Foundation

protocol UseCaseProvider {
    func makeUserUseCase() -> UserUseCase
    func makeUserDetailUseCase() -> UserDetailUseCase
}
