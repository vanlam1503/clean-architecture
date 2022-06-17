//
//  Cache.swift
//  Extensions
//
//  Created by Lam Le on 17/06/2022.
//

import Foundation

struct Cache {

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
