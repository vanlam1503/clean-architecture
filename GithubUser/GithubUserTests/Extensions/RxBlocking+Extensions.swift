//
//  RxBlocking+Extensions.swift
//  GithubUserTests
//
//  Created by Lam Le on 17/06/2022.
//

import RxBlocking

extension BlockingObservable {

    func firstOrNil() -> Element? {
        do {
            return try first()
        } catch {
            return nil
        }
    }
}
