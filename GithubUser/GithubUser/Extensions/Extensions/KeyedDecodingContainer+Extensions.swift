//
//  KeyedDecodingContainer+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation

infix operator <-: AssignmentPrecedence

public func <-<T: Decodable>(lhs: inout T?, rhs: T) {
    lhs = rhs
}

public func <-<T: Decodable>(lhs: inout T, rhs: T?) {
    guard let rhs = rhs else { return }
    lhs = rhs
}

public extension KeyedDecodingContainer where K: CodingKey {

    subscript<T: Decodable>(key: K) -> T? {
        try? decodeIfPresent(T.self, forKey: key)
    }

    subscript<T: RawRepresentable>(key: K) -> T? where T.RawValue: Decodable {
        if let rawValue = try? decodeIfPresent(T.RawValue.self, forKey: key) {
            return T(rawValue: rawValue)
        }
        return nil
    }
}
