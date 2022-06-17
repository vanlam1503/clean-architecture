//
//  ExpectEqual.swift
//  GithubUserTests
//
//  Created by Lam Le on 17/06/2022.
//

import Foundation
import XCTest

struct ExpectEqual<T> {

    let value: T

    init(_ value: T) {
        self.value = value
    }
}

func expect<T>(_ value: T) -> ExpectEqual<T> {
    .init(value)
}

func == <T: Equatable>(lhs: ExpectEqual<T>, rhs: T) {
    XCTAssertEqual(lhs.value, rhs)
}

func fail(_ message: String) {
    XCTFail(message)
}
