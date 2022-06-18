//
//  ObservableType+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

extension ObservableType {

    func onSuccess<Value, Error>() -> Observable<Value> where Element == Result<Value, Error> {
        return self.compactMap { result in
            if case .success(let value) = result {
                return value
            }
            return nil
        }
    }

    func onFailure<Value, Error>() -> Observable<Error> where Element == Result<Value, Error> {
        return compactMap { result in
            if case .failure(let error) = result {
                return error
            }
            return nil
        }
    }

    func mapObject<Value: Decodable, Error>(to type: Value.Type) -> Observable<Result<Value, Error>> where Element == Result<Data, Error> {
        return compactMap { result in
            switch result {
            case .success(let data):
                let value = try JSONDecoder().decode(type.self, from: data)
                return .success(value)
            case .failure(let error):
                return .failure(error)
            }
        }
    }

    func cache<Value: Codable, Error>(key: String, storeAt cache: ResponseCache.Type) -> Observable<Element> where Element == Result<Value, Error> {
        return self.do(onNext: { result in
            switch result {
            case .success(let value):
                cache.store(key: key, value: value)
            case .failure: break
            }
        })
    }

    func getCache<Value: Decodable, Error>(key: String, storedAt cache: ResponseCache.Type) -> Observable<Element> where Element == Result<Value, Error> {
        return self.map { result in
            switch result {
            case .success(let value):
                return .success(value)
            case .failure(let error):
                if let value: Value = cache.get(key: key) {
                    return .success(value)
                } else {
                    return .failure(error)
                }
            }
        }
    }
}

extension SharedSequenceConvertibleType {

    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
