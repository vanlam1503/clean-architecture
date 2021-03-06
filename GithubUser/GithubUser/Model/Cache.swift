//
//  Cache.swift
//  GithubUser
//
//  Created by Lam Le on 17/06/2022.
//

import UIKit

protocol ResponseCache {
    static func store<T>(key: String, value: T) where T: Encodable
    static func get<U>(key: String) -> U? where U: Decodable
}

struct Cache: ResponseCache {

    static func store<Value>(key: String, value: Value) where Value: Encodable {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func get<Value>(key: String) -> Value? where Value: Decodable {
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(Value.self, from: data) {
            return value
        }
        return nil
    }
}
