//
//  ApiClient.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum NetworkError: Error {
    case invalidUrl
}

typealias Completion<Value> = (Result<Value, NetworkError>) -> Void
typealias JSON = [String: Any]

protocol Cancellable {
    func cancel()
}

final class ApiClient {

    let manager: Session
    var request: Request?

    init() {
        // Configuration
        let configuration: URLSessionConfiguration = .default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.waitsForConnectivity = true

        manager = Session(
            configuration: configuration
        )
    }

    // MARK: - Old implementation
    @discardableResult
    public func makeCall(
        _ router: Router,
        completion: @escaping Completion<Data>) -> Request? {
            self.request = manager.request(router).response { response in
                guard let data = response.data else {
                    return
                }
                completion(.success(data))
            }
            return request
        }
}

// MARK:
extension ApiClient: Cancellable {

    func cancel() {
        request?.cancel()
    }
}

// MARK: - Reactive
extension Reactive where Base: ApiClient {

    func makeCall(_ router:  Router) -> Observable<Result<Data, NetworkError>> {
        return Observable.create { observer in
            base.makeCall(router) { result in
                observer.onNext(result)
            }
            return Disposables.create {
                base.cancel()
            }
        }
    }
}

// MARK: - Config
extension ApiClient {

    struct Config {
        static let timeOut: TimeInterval = 30
    }
}
