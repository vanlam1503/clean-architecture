//
//  ViewModelType.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
