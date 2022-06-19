//
//  Cache.swift
//  GithubUser
//
//  Created by Lam Le on 17/06/2022.
//

import UIKit
import Extensions

typealias ResponseCache = Extensions.ResponseCache

struct Cache: ResponseCache {

    static func store<T>(key: String, value: T) where T : Mapper {
        if let data = try? value.objectToData() {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    static func get<U>(key: String) -> U? where U : Mapper {
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
           let value = try? U.dataToObject(data) {
            return value
        }
        return nil
    }

}
