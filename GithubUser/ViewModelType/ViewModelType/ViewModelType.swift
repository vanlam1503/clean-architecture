//
//  ViewModelType.swift
//  ViewModelType
//
//  Created by Lam Le V. on 7/31/22.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
