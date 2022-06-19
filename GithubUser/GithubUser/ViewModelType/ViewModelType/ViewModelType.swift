//
//  ViewModelType.swift
//  ViewModelType
//
//  Created by Lam Le V. on 6/18/22.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
