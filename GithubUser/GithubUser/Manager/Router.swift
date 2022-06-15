//
//  Router.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import Alamofire

typealias ParameterEncoding = Alamofire.ParameterEncoding
typealias HTTPMethod = Alamofire.HTTPMethod
typealias Parameters = Alamofire.Parameters
typealias HTTPHeaders = Alamofire.HTTPHeaders
typealias URLEncoding = Alamofire.URLEncoding

protocol Router: URLRequestConvertible {
    var urlString: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters { get }
}

extension Router {

    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: urlString, method: method, headers: headers)
        return try encoding.encode(request, with: parameters)
    }
}
