//
//  ObservableType+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import RxSwift
import RxCocoa

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
}

extension SharedSequenceConvertibleType {

    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
