//
//  Mapper.swift
//  Extensions
//
//  Created by Lam Le V. on 6/19/22.
//

import Foundation

public protocol Mapper {
    static func dataToObject(_ data: Data) throws -> Self
    func objectToData() throws -> Data
}

extension Mapper where Self: Decodable {
    static func dataToObject(_ data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}

extension Mapper where Self: Encodable {

    func objectToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
