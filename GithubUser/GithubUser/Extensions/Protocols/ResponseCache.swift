//
//  ResponseCache.swift
//  Extensions
//
//  Created by Lam Le V. on 6/18/22.
//

import Foundation

public protocol ResponseCache {
    static func store<T>(key: String, value: T) where T: Encodable
    static func get<U>(key: String) -> U? where U: Decodable
}
