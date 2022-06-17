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

enum NetworkError: Swift.Error {
    case invalidUrl
    case disconnect
    case timeout
    case cancel
    case noResponse
    case error(Error)
}

typealias Completion<Value> = (Result<Value, NetworkError>) -> Void
typealias JSON = [String: Any]

protocol Cancellable {
    func cancel()
}

protocol ApiClientProtocol: ReactiveCompatible {
    func makeCall(_ router: Router, completion: @escaping Completion<Data>) -> Request?
}

final class ApiClient: ApiClientProtocol {

    private let manager: Session
    private var request: Request?

    static let shared = ApiClient()

    private init() {
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
    func makeCall(
        _ router: Router,
        completion: @escaping Completion<Data>) -> Request? {
            guard NetworkReachabilityManager()?.isReachable == true else {
                completion(.failure(.disconnect))
                return nil
            }
            self.request = manager.request(router).response { response in
                guard NetworkReachabilityManager()?.isReachable == true else {
                    completion(.failure(.disconnect))
                    return
                }
                let statusCode = response.response?.statusCode
                if statusCode == NSURLErrorTimedOut {
                    completion(.failure(.timeout))
                    return
                }
                if statusCode == NSURLErrorCancelled {
                    completion(.failure(.cancel))
                    return
                }
                if let error = response.error {
                    completion(.failure(.error(error)))
                    return
                }
                guard let data = response.data else {
                    completion(.failure(.noResponse))
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

// MARK: - ReactiveCompatible
extension ApiClient: ReactiveCompatible {}

// MAKR: - ApiClientService
protocol ApiClientService {
    func makeCall(_ router:  Router) -> Observable<Result<Data, NetworkError>>
}
// MARK: - Reactive

extension Reactive: ApiClientService where Base: ApiClient {

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
