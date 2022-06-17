//
//  MockApiClient.swift
//  GithubUserTests
//
//  Created by Lam Le on 17/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

@testable import GithubUser

final class MockApiClient: ApiClientService {

    var router: Router!
    var stubData: StubData

    enum StubData {
        case success(Data)
        case failure(NetworkError)
    }

    init(stubData: StubData) {
        self.stubData = stubData
    }


    func makeCall(_ router: Router) -> Observable<Result<Data, NetworkError>> {
        self.router = router
        switch stubData {
        case .success(let data):
            return Observable.just(.success(data))
        case .failure(let error):
            return Observable.just(.failure(error))
        }
    }
}
